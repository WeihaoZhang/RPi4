git clone -b dev https://github.com/WeihaoZhang/RPi4.git
cd Rpi4
./env_set.sh
从repo init -u ssh://git@gitmirror.cixtech.com/cix_val/diags/manifest -b master -m default.xml 下载的主线代码中拷贝acpica和toolchain到Rpi目录下

在SD卡创建EFI/BBOT目录，将inp.in放入EFI/BOOT目录，运行./build.sh编译 ，结束将Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd放入根目录，Build/RPi4/DEBUG_GCC5/AARCH64/Platform/RaspberryPi/RPi4/Application/SltFramework/SltFramework/OUTPUT/SltFramework.efi放入EFI/BOOT目录并命名为BOOTAA64.EFI
