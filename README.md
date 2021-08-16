# HST YAML backup script by Rafa
Backup sollution for all YAML files in OpenShift projects managed by HST

## How to:
### 1) Copy yaml_backup.sh file to server with OC binary installed directly connected to Open Shift API

### 2) Give permission to execute:
```bash
$ chmod +x yaml_backup.sh
```
### 3) Execute:
```bash
$ ./yaml_backup.sh
```
### 4) Provide details, example for EU OCP1 below:
```bash
Cluster API address without http and https prefixes:
cluster.ocp1.sr1.eu1.sp.ibm.local
Cluster API port:
8443
User name:
rafal.klimczak2@ibm.com
Password: [PASSWORD]
```
### 5) After some time the script will execute and show up:
 ```bash
###Creating archive [DONE]###
###Removing temporary files [DONE]###
###YAML FILES BACKUP DONE###
```
### 6) Result file is tar archive with name convention **DATE_yaml_backup_OWNER_ID.tar**
```bash
rklimczak@eu1sr1ljmp01:~$ ll | grep -i yaml_backup
-rw-------   1 rklimczak rklimczak 2037760 Jul 19 23:32 21-07-19-23-32-27_yaml_backup_Rafal.Klimczak2@ibm.com.tar
```
**Archive structure:**
```
BACKUP.tar
├── Project (namespace)
    └── resource type
    │     ├── object1.yaml
    │     ├── object2.yaml
    │     ├── object(n).yaml
    log.txt
```
