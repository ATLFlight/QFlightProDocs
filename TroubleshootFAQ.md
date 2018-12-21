# Troubleshooting and FAQs
This page provides answers to common questions, solutions to common problems and other how-tos for the Qualcomm Flight Pro™.

1. [Host computer requirements](#host-computer-requirements)
1. [Revive board that will not boot](#revive-board-that-will-not-boot)
1. [Serial console adapter board](#serial-console-adapter-board)
   1. [Older versions](#older-versions)
   1. [Pin compatibility issues](#pin-compatibility-issues)
1. [apt-get does not work](#apt-get-does-not-work)
1. [Install OpenCV](#install-opencv)
1. [WiFi network connection](#wifi-network-connection)  
1. [Wired ethernet connection](#wired-ethernet-connection)
1. [USB3 cable](#usb3-cable)
1. [USB-to-serial debug cable](#usb-to-serial-debug-cable)
1. [Debugging ADB problems](#debugging-adb-problems)
1. [Unable to flash platform BSP](#unable-to-flash-platform-bsp)
1. [Debugging IMU issues](#debugging-imu-issues)
1. [GPS support](#gps-support)
1. [Build your own drone](#build-your-own-drone)
1. [Change root login](#change-root-login)
1. [Find platform version](#find-platform-version)

## Host computer requirements
A host PC running Ubuntu 14.04 Linux is recommended for building code, debugging and testing the Qualcomm Flight Pro™ board (newer versions of the host OS may work too but have not been tested or officially supported).

## Revive board that will not boot
If your Qualcomm Flight Pro™ board does not boot up, you may be able to recover it as follows:

If your board gets bricked, the SD card recovery method may work IF the partitions are untouched. 

To create the recovery SD card, please do the following:
- Download the SD card image from the [support site](https://www.intrinsyc.com/contact-support).
- Insert an 8G MicroSD card into its adapter.
- Insert the adapter into an an SD card reader.
- Plug the SD card reader into a Linux PC.
- Determine the ```/dev/sd*``` device corresponding to your SD card.
- Flash the image to the SD card:
```sudo dd if=singleimage.bin of=<SD card device root>```  

EXAMPLE: ```sudo dd if=singleimage.bin of=/dev/sdx```  

*WARNING* Use the correct /dev/sd* device for your system otherwise you may overwite your hard drive!

- Once the image is flashed, power off the target.
- Insert the MicroSD card into the Qualcomm Flight Pro MicroSD card slot and power it back on.
- This should put the device into fastboot, and you can now flash a build.
- Run the following command and ensure that your device appears in the list:
```fastboot devices```   
- Remove the SD card before proceeding further.

*NOTE:* If the above option does not work, please contact [support](https://www.intrinsyc.com/contact-support) to get it reflashed.

## Serial console adapter board  
The serial console adapter board and cable are available as part of the [Qualomm Flight Pro™ developer's edition](https://shop.intrinsyc.com/products/qualcomm-flight-pro-development-kit). This allows the board to be accessed through a USB connector for debugging purposes. It also provides jumpers to force the board in fastboot and other special modes if necessary.

### Older versions
Some customers may have received an older deprecated version of the serial console adapter board does not include the fastboot jumper support. Please look at the MCN printed on the board to identify it:
  - 25-H9563 - Older serial console board, it does not include the fastboot jumper pins
  - 25-H9916 - New serial console board, it includes the fastboot jumper pins (J4)  

If you have the older version, please contact [support](https://www.intrinsyc.com/contact-support) to get the newer Serial Console Adapter board.

### Pin compatibility issues
Some serial console adapter parts have all 4 pins on the header whereas they should only have 3. If you have such a part, please *clip pin 2* on the header. This allows the FTDI serial cable to be inserted in only 1 way as below:
 
Pin 1 (TXD) Orange  
Pin 3 (RXD) Yellow  
Pin 4 (GND) Black

## apt-get does not work  
apt-get is NOT supported on this platform. To install new packages, you need to build them in a docker container *when* it is available (see [this page](HelloWorldDocker.md) for details).

## Install OpenCV  
The procedure to build and install OpenCV *will be provided later*.

## WiFi network connection

### Station mode
Update the ```/data/misc/wifi/wpa_supplicant.conf``` file on target to connect to the WiFi network of your choice.

To set wifi to station mode and camp on the WiFi network:
```$ atl-wifi-mode.sh station ```
OR
```$ echo sta > /data/misc/wifi/wlan_mode```

Reboot the target and check the network configuration:
```
$ systemctl reboot
$ ifconfig wlan0
```

You should now see a DHCP-assigned IP address.

### Soft AP mode
This is the default mode. To connect to the default SSID on target, look for  "QSoftAP" on the available wireless connections from your host PC/device and click Connect using password: ```1234567890```.

To set WiFi to softAP mode and connect to a certain SSID:
```
$ atl-wifi-mode.sh softap [optional-ssid]
$ systemctl reboot
```
Update the "ssid" in the ```/data/misc/wifi/sta_mode_hostapd.conf``` file on target to an identifiable string.
``` 
$ echo softap > /data/misc/wifi/wlan_mode
$ systemctl reboot
```
Check the network configuration
```$ ifconfig wlan0```
You should now see the IP address as 192.168.1.1 and be able to connect to the soft AP from a host PC or device.

### Antenna
A WiFi antenna is NOT included in the kit. It needs be purchased (ex. [Molex part# 146153-0150](http://www.molex.com/molex/products/datasheet.jsp?part=active/1461530150_ANTENNAS.xml)) and installed. See [here](UserGuide.md#wifi-control) for installation and setup.

## Wired ethernet connection  
The board can be connected to the network over a wired connection via the OTG USB port by using a USB Ethernet adapter (such as http://www.apple.com/shop/product/MC704LL/A/apple-usb-ethernet-adapter OR Linksys USB 3.0 Gigabit Ethernet Adapter - model USB3GIGV1) along with a USB 2.0 Female to Micro USB Male OTG adapter (such as http://www.rakuten.com/prod/268480078.html).

## USB3 cable  
Any standard USB micro-B cable may be used with the board. But in order to get USB 3.0 SuperSpeed functionality, one requires a MICRO-A PLUG TO STD-A cable (such as the Amphenol RUB30-0075 http://www1.amphenol-ast.com/v3/en/product_view.aspx?id=189).

## USB-to-serial debug cable
The USB-to-Serial Debug Cable that plugs into the Serial Console Adapter is the TTL-232R-3V3 part from FTDI modified to be 4-pins and keying added to prevent incorrect insertion. For more information, see http://www.ftdichip.com/Support/Documents/DataSheets/Cables/DS_TTL-232R_CABLES.pdf.

## Debugging ADB problems
  - Verify that the Qualcomm Flight Pro target is listed when you type ```adb devices``` on the host computer?
  - Do ```ls -l /etc/udev/rules.d``` and check for the existance of the 51-android.rules file.
  - Verify that the following lines are present in your ```/etc/udev/rules.d/51-android.rules``` file? If not, add them and try again.
```
#for Device adb interface
SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
#for Fastboot bootloader interface
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
```
  - Do ```lsusb``` on the host PC after the Qualcomm Flight Pro board is connected and powered up. You must see an entry for the target (usually listed as ```Qualcomm, Inc. Qualcomm HSUSB Device```).
  - Do ```adb kill-server``` and then ```adb start-server``` and try again?
  - If none of this works, verify that adb is functional on your host computer by connecting a phone or other device.
  - Try replacing the cable. Sometimes the microUSB 3.0 cable does not work, and you might need a microUSB 2.0 cable.

## Unable to flash platform BSP
Information will be available *later*.

## Debugging IMU issues
Do the following steps if you experience issues that may be due to IMU data. This is a test utility to verify that IMU data is being received correctly.

On the host machine via a separate terminal (*optional*):
``` ${HEXAGON_SDK_ROOT}/tools/mini-dm/Linux_Debug/mini-dm ```

On the target:

```shell
cd /home/root

# Run the imu_app (in the background)
./imu_app &
 
# Run the sensor_imu_tester app for 'n' seconds
./sensor_imu_tester <n>
## It should run and then say "test completed..."
## It should log the IMU data in a file called IMU-*.txt
 
# Stop the imu_app
VAR=$(ps -eaf | grep imu_app | grep -v grep | awk '{print $2}' | cut -d' ' -f2); kill $VAR
```

If the IMU_*.txt file was not created or the IMU data in it does not look correct, please try the following:
- Ensure that you installed the latest versions platform BSP from [here](http://support.intrinsyc.com).
- Post your issue on the [QDN forum](https://developer.qualcomm.com/forums/hardware/qualcomm-flight-pro) with a snippet of the target console log as well as the log from mini-dm.

## GPS support
Information will be available *later*.

## Build your own drone
An almost ready-to-fly drone kit compatible with Qualcomm Flight Pro™ and [Qualcomm Navigator](https://developer.qualcomm.com/hardware/snapdragon-flight/sd-navigator)™ called the [Dragon Drone Development Kit](https://worldsway.com/product/dragon-drone-development-kit) is now available. See [this post](https://developer.qualcomm.com/forum/qdn-forums/hardware/snapdragon-flight/34688) for more information. This is the *recommended* option.

## Change root login
Information to accomplish this will be available *later*.

## Find platform version
To find out the platform BSP version, type the following on target:  
```version```  

