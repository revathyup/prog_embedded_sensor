#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/drivers/i2c.h>
#include <stdio.h>
#include <bme680_reg.h>

#define BME680_ADDR     0x77 // I2C address of BME680
#define I2C_LABEL       i2c0 // I2C bus label

int main(void)
{
    const struct device *i2c_bus = DEVICE_DT_GET(DT_NODELABEL(I2C_LABEL));

    if (!device_is_ready(i2c_bus)) {
        printk("I2C bus device not ready\n");
        return -1;
    }

    /* Check Chip ID */
    uint8_t id;
    if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, BME680_ID, &id) < 0) {
        printk("Could not communicate with sensor.\n");
        return -1;
    }

    if (id != 0x61) {
        printk("Invalid Chip ID: 0x%02x\n", id);
        return -1;
    }

    /* Read Temperature Calibration Parameters */
    uint8_t t1_lsb, t1_msb;
    if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, 0xE9, &t1_lsb) < 0 ||
        i2c_reg_read_byte(i2c_bus, BME680_ADDR, 0xEA, &t1_msb) < 0) {
        printk("Failed to read calibration parameters\n");
        return -1;
    }
    uint16_t par_t1 = (t1_msb << 8) | t1_lsb;

    uint8_t t2_lsb, t2_msb;
    if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, 0x8A, &t2_lsb) < 0 ||
        i2c_reg_read_byte(i2c_bus, BME680_ADDR, 0x8B, &t2_msb) < 0) {
        printk("Failed to read calibration parameters\n");
        return -1;
    }
    int16_t par_t2 = (t2_msb << 8) | t2_lsb;

    uint8_t t3;
    if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, 0x8C, &t3) < 0) {
        printk("Failed to read calibration parameters\n");
        return -1;
    }
    int8_t par_t3 = t3;

    /* Configure Sensor for Temperature Only */
    if (i2c_reg_write_byte(i2c_bus, BME680_ADDR, BME680_CTRL_HUM, 0x00) < 0) {
        printk("Failed to configure sensor\n");
        return -1;
    }
    uint8_t ctrl_meas = (0x02 << 5) | (0x00 << 2) | 0x01; // Temp oversampling 2x, Forced mode
    if (i2c_reg_write_byte(i2c_bus, BME680_ADDR, BME680_CTRL_MEAS, ctrl_meas) < 0) {
        printk("Failed to configure sensor\n");
        return -1;
    }

    while (1) {
        /* Trigger Measurement */
        ctrl_meas = (0x02 << 5) | (0x00 << 2) | 0x01;
        if (i2c_reg_write_byte(i2c_bus, BME680_ADDR, BME680_CTRL_MEAS, ctrl_meas) < 0) {
            printk("Failed to trigger measurement\n");
            return -1;
        }

        /* Wait for Measurement Completion */
        uint8_t status;
        do {
            if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, BME680_STATUS, &status) < 0) {
                printk("Failed to read status\n");
                return -1;
            }
        } while (status & (1 << 5)); // Check measuring bit (bit 5)

        /* Read Temperature ADC Values */
        uint8_t temp_msb, temp_lsb, temp_xlsb;
        if (i2c_reg_read_byte(i2c_bus, BME680_ADDR, BME680_TEMP_MSB, &temp_msb) < 0 ||
            i2c_reg_read_byte(i2c_bus, BME680_ADDR, BME680_TEMP_LSB, &temp_lsb) < 0 ||
            i2c_reg_read_byte(i2c_bus, BME680_ADDR, BME680_TEMP_XLSB, &temp_xlsb) < 0) {
            printk("Failed to read temperature data\n");
            return -1;
        }

        /* Combine into Raw Temperature */
        int32_t raw_temp = ((int32_t)temp_msb << 12) | ((int32_t)temp_lsb << 4) | (temp_xlsb >> 4);

        /* Temperature Compensation (Formula from Datasheet) */
        int32_t var1 = (raw_temp >> 3) - ((int32_t)par_t1 << 1);
        int32_t var2 = (var1 * par_t2) >> 11;
        int32_t var3 = (((var1 >> 1) * (var1 >> 1)) >> 12) * par_t3 >> 14;
        int32_t t_fine = var2 + var3;
        int32_t temp = (t_fine * 5 + 128) >> 8;

        /* Print Temperature to Console */
        int32_t temp_integer = temp / 100;      // Whole number part
        int32_t temp_fraction = temp % 100;     // Fractional part
        printk("Temperature: %d.%02d°C\n", temp_integer, temp_fraction);

        /* Wait 3 Seconds */
        k_sleep(K_SECONDS(3));
    }

    return 0;
}