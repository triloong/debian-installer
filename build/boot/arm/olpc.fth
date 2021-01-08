\ OLPC XO boot script

: check-ofw-version ( -- )
   " /" find-device " compatible" get-property
   abort" No compatible property on /" ( -- compatible$ )

   \ Good compatible strings
   " mrvl,mmp2"    2over sindex -1 <>  if  2drop exit  then
   " marvell,mmp3" 2over sindex -1 <>  if  2drop exit  then

   \ Try to be helpful
   cr
   " olpc,xo-1.75" 2swap sindex -1 <>  if
     ." Firmware Q4E00 or newer is needed to boot a Devicetree enabled kernel." cr
     cr
     ." One way to update is to copy http://dev.laptop.org/~quozl/q4e00ja.rom" cr
     ." to a FAT partition on a USB flash stick and run ""flash u:\q4e00ja.rom""" cr
     " show-sad" eval
   else
     ." This hardware or firmware revision is not supported. Sorry." cr
   then
   cr
   ." Aborting boot." cr
   abort
;

: set-model
   \ Make sure the model is sensible -- flash-kernel relies on this.
   " model" delete-property
   " OLPC XO-1.75" " model" string-property
;

visible unfreeze
check-ofw-version
set-model

" last:2,\vmlinuz" to boot-device
" last:2,\initrd.gz" to ramdisk
boot
