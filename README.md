# Deploying ANSYS-Fluent on Azure HPC in a Windows-Linux mode

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


## Deploy Azure CycleCloud
Azure CycleCloud is a free application that provides a simple, secure, and scalable way to manage compute and storage resources for HPC and Big Compute workloads.

(1) The Azure portal has a marketplace image to deploy Azure CycleCloud. The link below outlines the steps to deploy Azure CycleCloud. \
https://docs.microsoft.com/en-us/azure/cyclecloud/qs-install-marketplace?view=cyclecloud-8

(2) On the Azure bash or Windows Subsystem for Linux, install the CycleCloud CLI \
https://docs.microsoft.com/en-us/azure/cyclecloud/how-to/install-cyclecloud-cli?view=cyclecloud-8

## Deploy Azure NetApp Files
The steps below outline the process to deploy a NFS4.1 volume using Azure NetApp Files. This will be used as common share to the Windows and Linux nodes.
**This volume needs to be deployed in the same VNet as Azure CycleCloud.** 

(1) Create a NetApp Account: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-a-netapp-account 

(2) Set up a Capacity Pool: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#set-up-a-capacity-pool 

(3) Create a NFS Volume: https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-quickstart-set-up-account-create-volumes?tabs=azure-portal#create-nfs-volume-for-azure-netapp-files

## Deploy a CycleCloud Project for ANSYS Fluent. 
(1) Download the **ANSYS-Fluent** project folder from this repository to bash environment. 
(2) Upload the folder to your cyclecloud locker, using cyclecloud project upload <locker-name>
(3) Change the directory to ANSYS-Fluent/templates and upload the template to cyclecloud using \
  cyclecloud import_template -f pbs-ansys.txt
(4) The cluster template for ANSYS using PBS will now appear in the CycleCloud portal. 
  ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys-Cluster.PNG)
(5) 
  ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_1.PNG)
    ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_2.PNG)
    ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_3.PNG)
    https://docs.microsoft.com/en-us/azure/cyclecloud/how-to/projects?view=cyclecloud-8

