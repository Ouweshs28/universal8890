# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Primal Kernel by kylothow @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=gracerlteskt
device.name2=gracerltelgt
device.name3=gracerltektt
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/platform/155a0000.ufs/by-name/BOOT;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
# permission settings will be added here


## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.samsungexynos8890
patch_fstab fstab.samsungexynos8890 /system ext4 flags "wait,verify" "wait"
patch_fstab fstab.samsungexynos8890 /data ext4 flags "wait,check,forceencrypt=footer" "wait,check,encryptable=footer"

# fstab.samsungexynos8890.fwup
patch_fstab fstab.samsungexynos8890.fwup /system ext4 flags "wait,verify" "wait"

# default.prop
patch_prop default.prop "ro.secure" "0";
patch_prop default.prop "ro.adb.secure" "0";
patch_prop default.prop "ro.debuggable" "1";
patch_prop default.prop "persist.sys.usb.config" "mtp,adb";
insert_line default.prop "persist.service.adb.enable=1" after "persist.sys.usb.config=mtp,adb" "persist.service.adb.enable=1";
insert_line default.prop "persist.service.debuggable=1" after "persist.service.adb.enable=1" "persist.service.debuggable=1";
insert_line default.prop "persist.adb.notify=0" after "persist.service.debuggable=1" "persist.adb.notify=0";

# end ramdisk changes

write_boot;

## end install

