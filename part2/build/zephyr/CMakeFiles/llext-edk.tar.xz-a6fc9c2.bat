@echo off
cd /D C:\Users\upill\zephyrproject\lab3_sensors_template\lab3_sensors_template-main\part2\build\zephyr || (set FAIL_LINE=2& goto :ABORT)
"C:\Program Files\CMake\bin\cmake.exe" -E make_directory edk/include/generated/zephyr || (set FAIL_LINE=3& goto :ABORT)
C:\Users\upill\zephyrproject\.venv\Scripts\python.exe C:/Users/upill/zephyrproject/zephyr/scripts/build/gen_syscalls.py --json-file C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/misc/generated/syscalls.json --base-output edk/include/generated/zephyr/syscalls --syscall-dispatch edk/include/generated/zephyr/syscall_dispatch.c --syscall-list C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/edk/include/generated/zephyr/syscall_list.h --split-type k_timeout_t --split-type k_ticks_t || (set FAIL_LINE=4& goto :ABORT)
"C:\Program Files\CMake\bin\cmake.exe" -DPROJECT_BINARY_DIR=C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr -DAPPLICATION_SOURCE_DIR=C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2 -DINTERFACE_INCLUDE_DIRECTORIES="C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/include/generated/zephyr C:/Users/upill/zephyrproject/zephyr/include C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/include/generated C:/Users/upill/zephyrproject/zephyr/soc/raspberrypi/rpi_pico C:/Users/upill/zephyrproject/zephyr/lib/libc/newlib/include C:/Users/upill/zephyrproject/zephyr/lib/libc/common/include C:/Users/upill/zephyrproject/zephyr/soc/raspberrypi/rpi_pico/common/. C:/Users/upill/zephyrproject/zephyr/soc/raspberrypi/rpi_pico/rp2040/. C:/Users/upill/zephyrproject/modules/hal/cmsis/CMSIS/Core/Include C:/Users/upill/zephyrproject/zephyr/modules/cmsis/. C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/common/pico_base_headers/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/boot_bootrom_headers/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_base/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_clocks/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_watchdog/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_xosc/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_pll/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_irq/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_sync/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_timer/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_resets/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_boot_lock/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_ticks/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_sync_spin_lock/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/pico_bootrom/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/pico_flash/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/pico_platform_compiler/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/pico_platform_sections/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/pico_platform_panic/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/common/boot_picoboot_headers/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/common/boot_picobin_headers/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2040/hardware_regs/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2040/hardware_structs/include C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2040/pico_platform/include C:/Users/upill/zephyrproject/zephyr/modules/hal_rpi_pico C:/Users/upill/zephyrproject/modules/hal/rpi_pico/src/rp2_common/hardware_gpio/include" -Dllext_edk_file=C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/llext-edk.tar.xz -Dllext_edk_cflags="-DKERNEL -D__ZEPHYR__=1 -D_ANSI_SOURCE -D__LINUX_ERRNO_EXTENSIONS__ -D__PROGRAM_START -DPICO_RP2040 -DK_HEAP_MEM_POOL_SIZE=4096 -DLL_EXTENSION_BUILD -fno-strict-aliasing -Og -imacros C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part2/build/zephyr/include/generated/zephyr/autoconf.h -fno-common -fdiagnostics-color=always -mcpu=cortex-m0plus -mthumb -mabi=aapcs -mfp16-format=ieee -imacros C:/Users/upill/zephyrproject/zephyr/include/zephyr/toolchain/zephyr_stdint.h -Wall -Wformat -Wformat-security -Wformat -Wno-format-zero-length -Wdouble-promotion -Wno-pointer-sign -Wpointer-arith -Wexpansion-to-defined -Wno-unused-but-set-variable -Werror=implicit-int -fno-asynchronous-unwind-tables -fno-reorder-functions --param=min-pagesize=0 -fno-defer-pop -std=c99 -mlong-calls -mthumb -nodefaultlibs" -Dllext_edk_name=llext-edk -DWEST_TOPDIR=C:/Users/upill/zephyrproject -DZEPHYR_BASE=C:/Users/upill/zephyrproject/zephyr -DCONFIG_LLEXT_EDK_USERSPACE_ONLY= -P C:/Users/upill/zephyrproject/zephyr/cmake/llext-edk.cmake || (set FAIL_LINE=5& goto :ABORT)
goto :EOF

:ABORT
set ERROR_CODE=%ERRORLEVEL%
echo Batch file failed at line %FAIL_LINE% with errorcode %ERRORLEVEL%
exit /b %ERROR_CODE%