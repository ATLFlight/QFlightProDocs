# Ground Vehicles

The following information documents the provisioning of a Turtlebot 2 as a ground vehicle reference platform.



## Getting Started with the Turtlebot2 Ground Vehicle
### Hardware
You'll need the following pieces of hardware to begin.  For the peripherals such as hub and usb cables, the links show the actual parts used in the prototype system.  However, other parts may also be suitable.

- [Turtlebot 2 Core Kit](https://dabit.industries/products/turtlebot-2-core-kit)
- [Qualcomm Flight Board](https://shop.intrinsyc.com/collections/product-development-kits/products/)
- [Micro USB Male to USB OTG cable](https://www.startech.com/Cables/USB-2.0/USB-Adapters/5in-Micro-USB-to-USB-OTG-Host-Adapter-Male-to-Female~UUSBOTG)
- [USB Hub](https://www.monoprice.com/product?c_id=103&cp_id=10307&cs_id=1030702&p_id=6631&seq=1&format=2)
- Molex Power Cable for Board

The following guidelines will provide assembly instructions for the Turtlebot and Qualcomm Flight Board.  If not explicitly mentioned, it is best to secure the components since this will be a moving platform.  Double sided tape can be used if there is no way to use the mounting holes in the platform.  

#### Turtlebot and Qualcomm Flight Board Assembly
Assemble the plates and 3D depth sensor with the base as presented in the [Turtlebot 2 Core Kit](https://dabit.industries/products/turtlebot-2-core-kit).  Mount the Qualcomm Flight Board somewhere on the plates.  The installation documented here does not use the tracking camera.  If you plan to integrate a solution to use the tracking camera, then it may be best for the Qualcomm Flight Board to be mounted on the top plate so that the tracking camera has visibility to its surroundings.  

#### Power Assembly
Secure and connect the Qualcomm Flight Board power adapter (APM) to the board.  Use the Molex Power Cable for the Qualcomm flight board to get power from the 12V@5A Molex connection found on the base of Kobuki.  Consult the [Turtlebot user guide](https://docs.google.com/document/d/15k7UBnYY_GPmKzQCjzRGCW-4dIP7zl_R_7tWPLM0zKI/edit) for additional information.

#### Peripheral Assembly
Next, setup the USB Hub to connect peripheral devices to the Qualcomm Flight Board.  Connect the micro USB OTG cable to the female USB connection on the board.  Connect the USB Hub to the OTG cable.  The USB cable that comes with the Turtlebot base is connected to the Kobuki and the USB Hub.  Connect the USB cable from the Orbbec Astra to the USB Hub.  

### Platform Image

Make sure that you have the most up-to-date platform.  Instructions can be found [here](https://github.com/ATLFlight/QFlightDocs/blob/master/PlatformGettingStarted.md).

Many of the steps require the use of adb ([Android Debug Bridge](https://developer.android.com/studio/command-line/adb.html)) for communication via usb.  Make sure that your Qualcomm Flight board is connected via usb and that you have adb installed.


## Provisioning Turtlebot2

This setup will utilize existing ROS packages for the Turtlebot.  For background, see common Turtlebot2 bringup tutorials [here](http://wiki.ros.org/turtlebot_bringup/Tutorials) and select the "Indigo" version.

The core installation will provide mapping and navigation using the Kobuki wheel encoder and Astra sensor.  Extended installations may use the tracking camera for position.

### Building the Docker Image

To provide the packages needed for Turtlebot2, this must be built into the image.
See [Docker Setup](https://github.qualcomm.com/ATLFlight/QFlightProDocs/blob/develop/DockerSetup.md) for information on the process to include additional source and build procedure for the docker image.
