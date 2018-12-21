# Qualcomm Flight Pro User Guide
This page provides useful information about the Qualcomm® Flight Pro™ Kit (Developer's edition) available [here](https://shop.intrinsyc.com/products/qualcomm-flight-pro-development-kit). The Qualcomm® Flight Pro™ is a highly integrated second-generation board based on a Qualcomm® Snapdragon™ 820 series processor that targets consumer drones and robotics applications.

# Table of Contents
1. [Target Access](#target-access)
   - [ADB](#adb)
   - [SSH](#ssh)
1. [Logging](#logging)
   - [Apps processor](#apps-processor)
   - [SLPI](#slpi)
1. [Camera](#camera)
1. [Camera Frame Fan-out](#camera-fan-out)
1. [ToF](#tof)
1. [Useful utilities](#useful-utilities)
1. [Acronyms and abbreviations](#acronyms-and-abbreviations)
1. [Additional references](#additional-references)

## Target Access

### ADB
Information will be available *later*.

### SSH
To login to the board and run the commands remotely, do the following:
- Ensure that the target and host computer are connected to the same network.
- Determine the IP address of the target.
- Run the following commands to ssh to the device:
```$ ssh root@<IP Address>```
Enter the password (oelinux123) when prompted.

## Logging

### Apps processor

### Logging
- For logging from userspace modules, please use adb logcat.  
```adb logcat -v time | tee <filename>.log```
- For logging from kernel modules, you can use the serial console or adb shell dmesg.
```adb shell dmesg```

### Serial console
The serial console baud rate is 115200. On Linux, you can use the "screen" or miniterm. Look at /dev/ttyUSBx to find the serial port. For instance:  
```$ sudo miniterm.py /dev/ttyUSB0 115200```

When prompted, enter the username as "root" and password as "oelinux123".

### SLPI
Information will be available *later*.

### Fan control
A fan could be installed as follows that helps in cooling the CPU and helps in avoiding CPU frequencies to be limited and/or CPU to be overheated:  
- Connect the 5V fan to J6 on the Qualcomm Flight Pro board.  
- After bootup, run following commands:  
```
$ echo 0 > /sys/class/pwm/pwmchip0/export
$ echo 50000 > /sys/class/pwm/pwmchip0/pwm0/period
$ echo 25000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
  Fan ON
$ echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
  Fan OFF
$ echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
```

#### Serial console logging

## Camera
The Camera API test application (camera-test) may be used to dump frames from any of the installed cameras. For more on how to use this application and the various options, do the following on target: ```camera-test -h```

### Take a picture
To get images from the hi-resolution camera:  
```camera-test -f hires -t 10 -d 30 -s 1080p -b 2```
 
To get images from the tracking (optical flow) camera:  
```camera-test -Z 1 -f tracking -o 0 -t 10 -d 30```
 

### Record video
Run one of the following command(s) to record video:  
```recorder_gtest --gtest_filter=RecorderGtest.SessionWith1080p60fpsEncTrack```  
```recorder_gtest --gtest_filter=RecorderGtest.SessionWith1080p60fps480p30fpsSnapshotEncTrack```  

The output files would become available at ```/data/misc/qmmf/```.

### View FPV video stream
Information will be available *later*.

### Use cases
Information will be available *later*.

## Camera fan out  
The camera library actuall provides two set of APIs, the first set of APIs are called master APIs, the application that invokes them has
the full control of the camera, including setting parameters. For example, test application camera-test uses master APIs. The master APIs
are in /usr/include/camera.h  

However, while the app using master APIs is running, if other applications want to have read-only access to the frames produced by the same camera, they may use the second set of APIs, the subscriber APIs. ( /usr/include/camera_subscriber.h )  
The test app camera-subscriber-test uses those APIs
Example: first start the master app on hires camera
```camera-test -Z 0 -f hires -t 40```  
then start the subscriber app on the same camera id
```camera-subscriber-test -p 0  -t 20 -d 30```  
run ```camera-subscriber-test -h``` for more details

You may run multiple camera-subscriber-test on the same camera id

## Useful utilities

### Version utility
This is an on-target utlity that displays platform version information including QCT AU tag, list of unmerged gerrits and build time. Just run this command:  
```version```

### Package utility
The target image has default versions of pre-installed packages for libcamera, mv, snav and libautonomy. ```atl-pkg-utils``` is an on-target utility that provides the ability to query, remove and install packages (such as mv, snav and autonomy). For more information and usage, please run:  
```atl-pkg-utils.sh -h```

### WiFi utility
This is an on-target utlity to easily switch WiFi modes and connect to a network. For more information and usage, please run:  
```atl-wifi-mode.sh -h```

### Commision utility
Information will be available *later*.

### Docker package utility
Information will be available *later*.

## Acronyms and abbreviations
Information will be available *later*.

## Additional references
Please refer to the following pages and documents for additional information:  
- [ADB commands guide](https://developer.qualcomm.com/download/db410c/adb-commands-guide.pdf)
