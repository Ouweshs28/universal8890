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
device.name1=herolte
device.name2=heroltebmc
device.name3=herolteskt
device.name4=heroltelgt
device.name5=heroltektt
} # end properties

# shell variables
block=/dev/block/platform/155a0000.ufs/by-name/BOOT;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod 750 $ramdisk/init.primal.rc
chmod 750 $ramdisk/init.services.rc
chmod 750 $ramdisk/sbin/sysinit.sh


## AnyKernel install
dump_boot;

# begin ramdisk changes

if egrep -q "dream|G95" "/system/build.prop"; then
  ui_print " ";
  ui_print "# Patching ramdisk for S8/S8+ ported ROMs...";
  insert_line default.prop "ro.oem_unlock_supported=1" after "persist.security.ams.enforcing=1" "ro.oem_unlock_supported=1";
  replace_file init.environ.rc 750 dream/init.environ.rc;
  insert_line init.samsungexynos8890.rc "service visiond /system/bin/visiond" after "start secure_storage" "\n# AIR\nservice visiond /system/bin/visiond\n    class main\n    user system\n    group system camera media media_rw\n";
  replace_file property_contexts 644 dream/property_contexts;
  replace_file sbin/adbd 777 dream/sbin/adbd;
  replace_file sepolicy 644 dream/sepolicy;
  replace_file sepolicy_version 644 dream/sepolicy_version;
  replace_file service_contexts 644 dream/service_contexts;
fi;

if egrep -q "grace|N93" "/system/build.prop"; then
  ui_print " ";
  ui_print "Patching ramdisk for Note FE ported ROMs...";
  insert_line default.prop "ro.oem_unlock_supported=1" after "persist.security.ams.enforcing=1" "ro.oem_unlock_supported=1";
  replace_file init.environ.rc 750 grace/init.environ.rc;
  insert_line init.samsungexynos8890.rc "service visiond /system/bin/visiond" after "start secure_storage" "\n# AIR\nservice visiond /system/bin/visiond\n    class main\n    user system\n    group system camera media media_rw\n";
  replace_file property_contexts 644 grace/property_contexts;
  replace_file seapp_contexts 644 grace/seapp_contexts;
  replace_file sepolicy 644 grace/sepolicy;
  replace_file sepolicy_version 644 grace/sepolicy_version;
  replace_file service_contexts 644 grace/service_contexts;
  insert_line ueventd.samsungexynos8890.rc "/dev/vertex0             0660   media      media" after "/dev/block/platform/155a0000.ufs/by-name/STEADY    0660    system    system" "\n# Vision (VPU, SCORE)\n/dev/vertex0             0660   media      media\n/dev/vertex1             0660   media      media\n/dev/iva_ctl             0660   media      media";
fi;

if egrep -q "great|N95" "/system/build.prop"; then
  ui_print " ";
  ui_print "# Patching ramdisk for Note 8 ported ROMs...";
  insert_line default.prop "ro.oem_unlock_supported=1" after "persist.security.ams.enforcing=1" "ro.oem_unlock_supported=1";
  replace_file init.environ.rc 750 great/init.environ.rc;
  insert_line init.samsungexynos8890.rc "service visiond /system/bin/visiond" after "start secure_storage" "\n# AIR\nservice visiond /system/bin/visiond\n    class main\n    user system\n    group system camera media media_rw\n";
  replace_file property_contexts 644 great/property_contexts;
  replace_file sbin/adbd 777 great/sbin/adbd;
  replace_file sepolicy 644 great/sepolicy;
  replace_file sepolicy_version 644 great/sepolicy_version;
  replace_file service_contexts 644 great/service_contexts;
fi;

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

insert_line default.prop "ro.securestorage.support=false" after "debug.atrace.tags.enableflags=0" "ro.securestorage.support=false";
insert_line default.prop "ro.config.tima=0" after "ro.securestorage.support=false" "ro.config.tima=0";
insert_line default.prop "wlan.wfd.hdcp=disable" after "ro.config.tima=0" "wlan.wfd.hdcp=disable";

# init.samsungexynos8890.rc
insert_line init.samsungexynos8890.rc "import init.services.rc" after "import init.remove_recovery.rc" "import init.services.rc";
insert_line init.samsungexynos8890.rc "import init.primal.rc" after "import init.services.rc" "import init.primal.rc";

# end ramdisk changes

write_boot;

## end install

