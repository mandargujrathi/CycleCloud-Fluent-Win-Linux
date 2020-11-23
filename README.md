# CycleCloud-Fluent-Win-Linux

This repository will provide the steps to deploy and use ANSYS Fluent on Azure leveraging Azure VM's for High Performance Computing. 
This deployment will feature the following: \
(1) A low cost Windows VM as a front end to launch jobs directly from the Fluent Launcher GUI onto the Linux Compute nodes integrated with a PBS Scheduler. \
(2) The Linux compute nodes leverage the HBv2 machines featuring 200 Gb/sec Mellanox HDR InfiniBand. \
(3) Automatic scale down feature integrated in the deployment enables cost optimisation: scales the VM's down (and stops charging) when the Fluent job is complete. 

## Pre-requisites

(1) Azure Subscription \
(2) Subscription whitelisted for Azure NetApp Files (ANF) \
(3) Quota for HB_v2 VM's in the region of your choice \
(4) Bring Your Own ANSYS Fluent License (HPC enabled) 

### Services used
(1) Azure Cycle Cloud \
(2) Azure NetApp Files 

## Architecture

![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Architecture.PNG)


## Steps to deploy Azure CycleCloud
Azure CycleCloud is a free application that provides a simple, secure, and scalable way to manage compute and storage resources for HPC and Big Compute workloads.
The Azure portal has a marketplace image to deploy Azure CycleCloud. The link below outlines the steps to deploy Azure CycleCloud. \
https://docs.microsoft.com/en-us/azure/cyclecloud/qs-install-marketplace?view=cyclecloud-8

## Steps to deploy Azure NetApp Files
The steps below outline the process to deploy a NFS4.1 volume using Azure NetApp Files. This will be used as common share to the Windows and Linux nodes
**This volume needs to be deployed in the same VNet as Azure CycleCloud.** \
(1) Create a NetApp Account: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-a-netapp-account \

(2) Set up a Capacity Pool: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#set-up-a-capacity-pool \

(3) Create a NFS Volume: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-nfs-volume-for-azure-netapp-files
