#Created by: Rafal Klimczak HST Poland Team
#https://github.ibm.com/Rafal-Klimczak2/YAML_backup_script
#rafal.klimczak2@ibm.com
#####################################################################
#!/bin/bash

echo Cluster API address without http and https prefixes:
read cluster_address

echo Cluster API port:
read port

echo User name:
read username

echo Password:
read -s passwd

oc login https://$cluster_address:$port -u$username -p$passwd
oc get projects | awk '{print $1}'| awk '(NR>1)' > project_list

for i in $(cat project_list)
        do mkdir -p OCP_backup/$i/{pod,service,deployment.apps,job.batch,replicationcontroller,cronjob.batch,deploymentconfig.apps.openshift.io,route.route.openshift.io,statefulset.apps,daemonset.apps}
done


for i in $(cat project_list)
        do
                oc project $i &>/dev/null
                echo '###Working on project:'$i'###'
                oc get all --namespace=$i | awk '{print $1}' | grep -v 'imagestream.*\|replicaset.*\|NAME' > ./OCP_backup/$i/log.txt
                for x in $(cat ./OCP_backup/$i/log.txt)
                        do
                                oc get $x -o yaml > ./OCP_backup/$i/$x.yaml
                        done
        done
echo '###Creating archive [DONE]###'
tar -cf $(date +%y-%m-%d-%H-%M-%S)_yaml_backup_$(oc whoami).tar OCP_backup/
echo '###Removing temporary files [DONE]###'
rm -R OCP_backup
rm project_list

echo '###YAML FILES BACKUP DONE###'
