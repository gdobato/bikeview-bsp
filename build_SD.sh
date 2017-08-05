#!/bin/sh 

#Script scope variables
USAGE="$0 -d <mmcdevice> "
FORMATSCRIPT=./rpi/meta-rpi/scripts/mk2parts.sh
COPYBOOTSCRIPT=./rpi/meta-rpi/scripts/copy_boot.sh
COPYROOTFSSCRIPT='./rpi/meta-rpi/scripts/copy_rootfs.sh sdb qt5 bikeview-A0'


#example for mor arguments
#while getopts ":k:d:f:R:" OPT; do
while getopts ":d:" OPT; do
    case "$OPT" in
        d)
             DEVICE=$OPTARG
             ;;
        *)
             echo  $USAGE 1>&2
             exit 1
             ;;
    esac
done

#Check device argument
if [ "$DEVICE" = "sda" ]; then
    echo "Choose a sdcard/usb device!"
    echo $USAGE
    exit 1
fi

sudo $FORMATSCRIPT $DEVICE
sudo $COPYBOOTSCRIPT $DEVICE
sudo $COPYROOTFSSCRIPT


