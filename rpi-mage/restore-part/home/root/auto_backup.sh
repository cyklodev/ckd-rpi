#!/bin/bash
cd /home/root/

result(){

	if [[ $? -eq 0 ]]
	then
		echo "SUCCESS (${1})"
	else
		echo "ERROR (${2})"
	fi

}


./mount_all.sh 
result "Start mountint all" "Cannot mount volumes"

echo "start backuping"
./backup_working_partition.sh
result "start backuping" "Cannot start backuping"

echo "switch os boot"
#cp boot_restore.txt /mnt/cmdline.txt
cp boot_working.txt /mnt/cmdline.txt
result "switch os boot" "Cannot switch os boot"


cp /etc/rc.local.working /etc/rc.local
result "disable backup on boot " "cannot disable backup on boot " 



shutdown -r 0
