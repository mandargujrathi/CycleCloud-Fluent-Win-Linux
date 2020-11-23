# CycleCloud-Fluent-Win-Linux

This repository will provide the steps to set up and use ANSYS Fluent leveraging Azure VM's for High Performance Computing. This project uses the HB_v2 machines for compute, which feature 200 Gb/sec Mellanox HDR InfiniBand. 

## Pre-requisites

(1) Azure Subscription \
(2) Subscription whitelisted for Azure NetApp Files (ANF) \
(3) Quota for HB_v2 VM's in the region of your choice 

### Services used
(1) Azure Cycle Cloud \
(2) Azure NetApp Files 

## Architecture




## Steps to deploy Azure CycleCloud
Azure CycleCloud is a free application that provides a simple, secure, and scalable way to manage compute and storage resources for HPC and Big Compute workloads.
The Azure portal has a marketplace image to deploy Azure CycleCloud. The link below outlines the steps to deploy Azure CycleCloud. \
https://docs.microsoft.com/en-us/azure/cyclecloud/qs-install-marketplace?view=cyclecloud-8

## Steps to deploy Azure NetApp Files
The steps below outline the process to deploy a NFS4.1 volume using Azure NetApp Files. This will be used as common share to the Windows and Linux nodes
**This volume needs to be deployed in the same VNet as Azure CycleCloud.** \
https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-a-netapp-account \
https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#set-up-a-capacity-pool \
https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-nfs-volume-for-azure-netapp-files
