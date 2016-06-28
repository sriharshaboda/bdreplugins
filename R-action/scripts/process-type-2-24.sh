#!/bin/sh
. $(dirname $0)/../env.properties
BDRE_HOME=~/bdre
BDRE_APPS_HOME=~/bdre_apps
hdfsPath=/user/$bdreLinuxUserName
nameNode=hdfs://$nameNodeHostName:$nameNodePort
jobTracker=$jobTrackerHostName:$jobTrackerPort
hadoopConfDir=/etc/hive/$hiveConfDir
cd $BDRE_APPS_HOME

echo "Deploying R jobs"

#copy R shell script
cp $BDRE_HOME/bdre-scripts/deployment/Rhadoop.sh $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId
if [ $? -ne 0 ]
then exit 1
fi

dos2unix $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId/Rhadoop.sh