#include <zephyr/kernel.h>
#include <stdio.h>
#include <zephyr/device.h>
#include <zephyr/devicetree.h>
//#include <zephyr/drivers/gpio.h>
#include <zephyr/drivers/sensor.h>

// Define the sensor label
#define SENSOR_LABEL "BME680"

int main(void)
{
    // Get the device binding for the BME680 sensor
    const struct device *sensor = DEVICE_DT_GET(DT_NODELABEL(bme680));

    // Check sensor device ready
    if (!device_is_ready(sensor)) {
        printf("Error: BME680 sensor not found or not ready!\n");
        return -1;
    }

    printf("BME680 sensor initialized successfully!\n");

    // Main loop
    while (1) {
        struct sensor_value temp_value;

        //  latest sensor data
        if (sensor_sample_fetch(sensor) < 0) {
            printf("Error: Failed to fetch data from the sensor!\n");
            continue; // Skip to the next iteration if fetching fails
        }

        //get  temperature value from the sensor
        if (sensor_channel_get(sensor, SENSOR_CHAN_AMBIENT_TEMP, &temp_value) < 0) {
            printf("Error: Failed to read temperature data!\n");
            continue; // Skip to the next iteration if reading fails
        }

        // Convert the sensor value to a double 
        double temperature = sensor_value_to_double(&temp_value);
        printf("Temperature: %.2f°C\n", temperature);

        // Wait for 3 seconds before the next reading
        k_sleep(K_SECONDS(3));
    }

    return 0;
}