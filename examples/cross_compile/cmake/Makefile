native:
	rm -rf build
	mkdir build
	(cd build && cmake ..)
	(cd build && make)


SDKROOT?=/opt/sdk-122
cross:
	rm -rf build
	mkdir build
	(cd build && cmake -DSDKROOT=${SDKROOT} -DCMAKE_TOOLCHAIN_FILE=../crossbuild/Toolchain-arm-linux-gnueabihf.cmake ..)
	(cd build && make)
	
