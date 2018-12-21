# Camera Programming Documentation  
The camera programming APIs are provided by packages:   
- lib32-lib-robotics-camera  
## Camera master APIs  
APIs to start/stop/configure the camera.  
The APIs allows only one application process to control one camera.  That process is called master  

## Camera subscriber APIs  
APIs to subscribe to fan-out frames from the same camera controlled by the master application.    
There could be multiple subscriber applications.  

The subscriber application cannot change any camera settings.  
If the master application stops the camera, all subscribers are notified  

## Include path  
### Master APIs  
- /usr/include/camera.h  
- /usr/include/camera_parameters.h  
### Subscriber APIs  
- /usr/include/camera_subscriber.h  
- /usr/include/camera_subscriber_meta_data.h    

## Link Path  
- /usr/lib/libcamera.so  
## additional information  
- /usr/share/doc/camera/readme.md  
- /usr/share/doc/camera/pmd_tof_readme.md  
