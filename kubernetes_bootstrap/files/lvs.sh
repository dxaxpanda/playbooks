#!/bin/bash


sudo lvcreate --wipesignatures y -n thinpool docker -l 95%VG

lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG
sudo lvconvert -y \
  --zero n \
  -c 512K \
  --thinpool docker/thinpool \
  --poolmetadata docker/thinpoolmeta



lvchange --metadataprofile docker-thinpool docker/thinpool

lvs -o+seg_monitor

systemctl start docker
