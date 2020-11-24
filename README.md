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
(2) Azure NetApp Files (ANF) 

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
(1) Download the **ANSYS-Fluent** project folder from this repository to bash environment. \
(2) Upload the folder to your cyclecloud locker, using cyclecloud project upload <locker-name> \
(3) Change the directory to ANSYS-Fluent/templates and upload the template to cyclecloud using \
  cyclecloud import_template -f pbs-ansys.txt \
(4) The cluster for ANSYS using PBS will now appear in the CycleCloud portal as PBS-ANSYS. \
  ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys-Cluster.PNG)
(5) To start the cluster: \
(a) Click on the PBS-ANSYS logo, enter a name for the cluster and click Next \
  ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_1.PNG) 
  
(b) Select the VM's for master node and compute nodes. Make sure the Auto-Scaling check box is selected and enter the maximum number of core counts for the cluster. In the Networking section, select the Compute subnet (not the storage) and click Next \
     ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_2.PNG) 
     
(c)  Make sure the settings appear as per this page and click Save \
    ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_3.PNG) 
    
(d) The cluster will appear on the list, click on the Start button to start the master node of the cluster. \
    ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_4.PNG) 
    
(e) Connect (SSH in) to the head node from Azure bash and check whether the ANF volume is mounted. \
![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_5.PNG) 

(f) Here we can confirm that the Linux version of ANSYS has been installed on the share. \
![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_6.PNG) 

 (6) Go to the Azure portal and deploy a Windows VM (F16 series or similar) in the same VNet and the Resource group as Azure CycleCloud and ANF. \
 
 (7) Install the Windows version of ANSYS package and configure the License Manager on this Windows VM. Make sure the Firewall is tured off. \
 
 (8) Open CMD on the Windows VM and generate the public and private keys as below. This is required to enable passwordless ssh into the Linux cluster \
 ssh-keygen -t rsa \
 The keys are generated in the C:\Users\.ssh folder on the Windows VM. Copy the id_rsa.pub key. \
 
 (9) Go to the Cycle Portal. Navigate to Settings --> Users --> Create. Fill in the form to create the new user (Windows VM) and insert the copied public key for the Windows VM and hit save. This allows the keys of the Windows VM to be propagated into all the nodes of the cluster \
 ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_7.PNG) 
 
 (10) From the CMD on the Windows node, ssh into the master node using its host name. You can gather the host name from the CycleCloud portal. This will allow the knownhosts file to be created. If you have an older knownhosts file, make sure you delete that to avoid a conflict while running Fluent. \
 
 (11) On the Windows node, install the Windows NFSv4.1 client from below. This will allow to mount the ANF share on the Windows machine. 
 https://www.cohortfs.com/windows-nfsv41-client-64-bit-0
 From the Windows Explorer select map the network drive for mounting the ANF share (as Z:). You can obtain the server address by visiting the ANF pool resource within the Azure portal    and navigating to mount instructions. \
 ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_8.PNG) 
 
 (12) On the ANF share which is now mounted as Z:, do the following changes to the **fluent** script in the Linux installation. If  Linux version of ANSYS is installed in the folder ANSYS_Inc_Lnx then the script is found in Z:\ANSYS_Inc_Lnx\v202\fluent\bin path. These changes come approximately at Line 91
  ![alt text](https://github.com/mandargujrathi/CycleCloud-Fluent-Win-Linux/blob/main/Ansys_cycle_9.PNG) 
 
  
  https://docs.microsoft.com/en-us/azure/cyclecloud/how-to/projects?view=cyclecloud-8

