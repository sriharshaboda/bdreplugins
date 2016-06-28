#!/bin/sh
. $(dirname $0)/../env.properties
BDRE_HOME=~/bdre
BDRE_APPS_HOME=~/bdre_apps
hdfsPath=/user/$bdreLinuxUserName
nameNode=hdfs://$nameNodeHostName:$nameNodePort
jobTracker=$jobTrackerHostName:$jobTrackerPort
hadoopConfDir=/etc/hive/$hiveConfDir
cd $BDRE_APPS_HOME

echo "Deploying Teradata Query Runner jobs"

#copy TeradataQuery shell script
cp $BDRE_HOME/bdre-scripts/deployment/query-runner-remote.sh $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId
if [ $? -ne 0 ]
then exit 1
fi

#Upload files into the TD machine
#TODO: 10.0.0.11 IP should not be hardcoded
#ssh tduser@10.0.0.11 "rm -rf /home/tduser/tdquery/$busDomainId/$processTypeId/$processId"
#ssh tduser@10.0.0.11 "mkdir -p /home/tduser/tdquery/$busDomainId/$processTypeId/$processId"
#scp -r $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId/tdquery/* tduser@10.0.0.11:/home/tduser/tdquery/$busDomainId/$processTypeId/$processId