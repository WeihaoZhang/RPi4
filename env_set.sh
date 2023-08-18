git submodule update --init 
cd edk2 
git submodule update --init 
cd ../edk2-platforms 
git submodule update --init 
cd .. 
cp 0001-MdeModulePkg-UefiBootManagerLib-Signal-ReadyToBoot-o.patch edk2 
cd edk2 
git apply 0001-MdeModulePkg-UefiBootManagerLib-Signal-ReadyToBoot-o.patch