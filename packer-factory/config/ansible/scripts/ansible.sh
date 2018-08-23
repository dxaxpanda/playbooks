#!/bin/bash -eux

# setup epel repo
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# ansible setup
yum -y install ansible
