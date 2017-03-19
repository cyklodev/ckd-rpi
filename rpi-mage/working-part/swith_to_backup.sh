#!/bin/bash


result(){

	if [[ $? -eq 0 ]]
	then
		echo "SUCCESS (${1})"
	else
		echo "ERROR (${2})"
	fi

}


/home/pi/mount_restore.sh
result "Start mountint all" "Cannot mount volumes"

#cp boot_restore.txt /mnt/cmdline.txt
cp /mnt/home/root/boot_restore.txt /boot/cmdline.txt
result "switch os boot" "Cannot switch os boot"

cp /mnt/etc/rc.local.backuping /mnt/etc/rc.local
result "disable backup on boot " "cannot disable backup on boot " 



#shutdown -r 0

