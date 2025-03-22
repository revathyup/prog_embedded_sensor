# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "C:/Users/upill/zephyrproject/zephyr/modules/hal_rpi_pico/bootloader")
  file(MAKE_DIRECTORY "C:/Users/upill/zephyrproject/zephyr/modules/hal_rpi_pico/bootloader")
endif()
file(MAKE_DIRECTORY
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/bootloader"
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix"
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/tmp"
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/src/second_stage_bootloader-stamp"
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/src"
  "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/src/second_stage_bootloader-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/src/second_stage_bootloader-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/upill/zephyrproject/lab3_sensors_template/lab3_sensors_template-main/part1/build/modules/hal_rpi_pico/second_stage_bootloader-prefix/src/second_stage_bootloader-stamp${cfgdir}") # cfgdir has leading slash
endif()
