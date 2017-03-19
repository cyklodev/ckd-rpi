#!/bin/bash

echo "mounting restore partition"

mount /dev/mmcblk0p2 /mnt
mount /dev/sda1 /backup
