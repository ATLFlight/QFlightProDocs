# Qualcomm Flight Pro Specifications

## Main Board
SoC
- Qualcomm Snapdragon 820 (APQ8096)

Memories:
- DDR: SDHC 4 GB LPDDR4
- UFS: 32 GB, UFS 2.0, HS-G3 1-Lane
- SD Card: 4-bit microSD slot
- Platform ID EEPROM: Serial Flash

Sensors:
- IMU (Gyroscope, Accelerometer, Compass): Dual Invensense MPU9250
- Pressure sensor (Barometer): Bosch BMP280
- Off-Board/External: I2C and UART on several connector interfaces for expansion.

Connectivity
- WLAN/BT/FM QCA6174A 802.11ac 2x2
- NFA324 Module

GPS:
- Onboard: WGR7640
- Offboard: SirfStarV CSRG0530 B02

LEDs
- RGB and discrete Red and Green LEDs for on-board status.

Debugging:
- Ethernet: Through USB ethernet adapter - see [here](TroubleshootFAQ.md#wired-ethernet-connection) for details
- UART: Accessed on expansion connector
- JTAG: Accessed on expansion connector

### Cameras
One High Resolution camera 12.3MP IMX378 Sony sensor
- 4K at 30 fps
- Lite-on Module 4BCH05P1A
- MIPI 4-lane CSI-0

One Downward Facing Camera: OV7251 OmniVision sensor
- B & W VGA Sensor
- Sunny PJ103B module
- MIPI 1+1-Lane CSI-2

Two Stereo Cameras: OV7251 OmniVision sensor
- B & W VGA Sensor
- Sunny PJ103B module
- MIPI 1-Lane CSI-1

## Additional Kit Components

Advanced Power Module (APM) Cable:
- Smart and advanced power supply converter board, configured into a cable, to connect power to Qualcomm Flight from either the provided 5V DC power supply or a 2S-6S LiPo battery (regulated to 5V).
- The cable circuitry prioritizes the 5V DC external supply whenever present, and secondly the battery.
- Concurrent use of 2S-6S battery and external DC supply connected to the APM cable is supported.

Serial Console Adapter
- Customer adapter to support standard Linux console interface

Custom FTDI Debug Cable
- Cable (only 3 pins instead of the 6 provided by FTDI) with standard-A type USB plug for connecting the serial console adapter to Qualcomm Flight.

5V DC power supply

## Software
- Yocto OpenEmbedded-based build system
- Linux kernel 3.18
- Apps development through SDK (cross-compiler toolchain) and Docker container
