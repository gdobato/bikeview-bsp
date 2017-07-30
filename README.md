# BIKEVIEW - BSP

dobatog@gmail.com 

jenifer_blanco@hotmail.com


## Install 

    git clone git@gitlab.com:bikeview/bikeview-bsp.git
    cd bikeview-bsp
    ./install.sh

Notes:

 Set "no" at popup window.
 
 Let toolchain installation path as default.

## Build RPI image (More than 50Gb needed!)

    source poky-morty/oe-init-build-env rpi/build
    bitbake qt5-image

