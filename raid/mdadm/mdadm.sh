#!/bin/bash

BLOCKS=(/dev/vdb /dev/vdc)
MD_RAID=/dev/md127
yes |mdadm --create --verbose ${MD_RAID} --level=1 --raid-devices=2 ${BLOCKS[0]} ${BLOCKS[1]}

mkdir -p /etc/mdadm
touch /etc/mdadm/mdadm.conf

mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf

cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak

dracut -f
