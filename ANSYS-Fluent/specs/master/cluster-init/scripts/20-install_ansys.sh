#!/bin/bash
set -ex
# Note: This script is required to run only for the time when the ANF volume is set up for the FIRST use of ANSYS Fluent. 
# If you are using the same volume (which has ANSYS Fluent already installed) for any new clusters that follow you may comment this script altogether. 
# This script will ONLY run on the master node. 


sudo chmod 777 /ansysshare
sudo mkdir -p /ansysshare/ANSYS_Inc_Lnx
sudo mkdir -p /ansysshare/FLUIDS_2020R2_LINX64

sudo chmod 777 /ansysshare/ANSYS_Inc_Lnx
sudo chmod 777 /ansysshare/FLUIDS_2020R2_LINX64

#tmpdir=$(mktemp -d)
#pushd $tmpdir

jetpack download "FLUIDS_2020R2_LINX64.tar"

tar -xvf FLUIDS_2020R2_LINX64.tar -C /ansysshare/FLUIDS_2020R2_LINX64

sudo chmod 777 -R /ansysshare


sudo /ansysshare/FLUIDS_2020R2_LINX64/INSTALL -silent -install_dir "/ansysshare/ANSYS_Inc_Lnx/" -licserverinfo 2325:1055:52.152.144.188

