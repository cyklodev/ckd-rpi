#!/bin/bash

##########################################
#	Global vars
##########################################

RPI_IMG_PATH=""
RPI_IMG="$RPI_IMG_PATH/*-raspbian-jessie-lite.img"
TARGET_MOUNT_FOLDER="/mnt/rpi-custom"

##########################################
#	Some checks 
##########################################

USERID=`id -u` 

if [[ $USERID -ne 0 ]]
then
	echo "Not root !!! ";
	exit 100;
else
	echo "Root user ... continue"
fi

if [[ -z $RPI_IMG_PATH ]]
then
        echo 'Global vars $RPI_IMG_PATH is not set !!! ';
        exit 100;
else
        echo  ' Global vars $RPI_IMG_PATH present... '
	
fi


if ! ls ${RPI_IMG} 
then
        echo "The Raspbian img is not present ";
        exit 100;
else
        echo "The Raspbian img is present ... continue"
	#echo ${RPI_IMG}
fi

##########################################
#	Analyze the img
##########################################

echo ''
echo "Scope the img offset & units"
echo ''

RPI_OFFSET=`fdisk -l ${RPI_IMG} | grep Linux | awk '{print $2}'`
RPI_UNITS=`fdisk -l ${RPI_IMG} | grep Units | awk -F '=' '{print $3}' | awk '{ print $1}'`
RPI_MOUNT_OFFSET=$((${RPI_OFFSET}*${RPI_UNITS}))

echo ''
echo '##########################################'
echo "IMG           = ${RPI_IMG}"
echo "OFFSET        = ${RPI_OFFSET} "
echo "UNITS         = ${RPI_UNITS}"
echo "MOUNT_OFFSET  = ${RPI_MOUNT_OFFSET} "
echo '##########################################'
echo ''


echo 'Check the mounting folder'
echo ''
if [[ -d ${TARGET_MOUNT_FOLDER} ]]
then 
	echo 'Target folder exist'
else 
	echo 'Folder does not exist ... let s create it '
	mkdir -p ${TARGET_MOUNT_FOLDER}
fi 



echo ''
echo ''
echo '##########################################'
echo "EXEC :        mount -o loop,offset=${RPI_MOUNT_OFFSET} ${RPI_IMG}  ${TARGET_MOUNT_FOLDER}"
mount -o loop,offset=${RPI_MOUNT_OFFSET} ${RPI_IMG}  ${TARGET_MOUNT_FOLDER}
if [[ $? -eq 0 ]]
then
	echo "${TARGET_MOUNT_FOLDER}  mounted :)"
else
	echo "${TARGET_MOUNT_FOLDER}  ERROR [$?]  !!!!  :("
fi
echo '##########################################'

echo ''
echo "After unmouting the volume ${TARGET_MOUNT_FOLDER} you can securly write it with the following command"
echo "dd if="eval ${RPI_IMG}" of=YOURUSBKEYPATH bs=2M"


