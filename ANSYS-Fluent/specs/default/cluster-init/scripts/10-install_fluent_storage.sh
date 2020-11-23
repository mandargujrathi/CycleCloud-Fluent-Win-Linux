#!/bin/bash
set -ex


sudo mkdir -p /ansysshare
sudo chmod 777 /ansysshare

sleep 1m
sudo mount -t nfs -o rw,hard,rsize=1048576,wsize=1048576,sec=sys,vers=4.1,tcp 10.122.104.132:/ansysvol1 /ansysshare
#sudo yum -y install dos2unix
sudo yum -y install ksh
