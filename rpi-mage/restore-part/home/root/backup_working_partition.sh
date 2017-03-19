#!/bin/bash
e2fsck /dev/mmcblk0p3



time dd if=/dev/mmcblk0p3 of=/backup/test.dd bs=1M conv=sparse
