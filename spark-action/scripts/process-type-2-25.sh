#!/bin/sh
. $(dirname $0)/../env.properties
BDRE_HOME=~/bdre
BDRE_APPS_HOME=~/bdre_apps
hdfsPath=/user/$bdreLinuxUserName
nameNode=hdfs://$nameNodeHostName:$nameNodePort
jobTracker=$jobTrackerHostName:$jobTrackerPort
hadoopConfDir=/etc/hive/$hiveConfDir
cd $BDRE_APPS_HOME

echo "Deploying Spark jobs"

mkdir -p $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId/spark
if [ $? -ne 0 ]
then exit 1
fi

#copying spark-core jar
cp $BDRE_HOME/lib/spark-core/spark-core-$bdreVersion.jar $BDRE_APPS_HOME/$busDomainId/$processTypeId/$processId/lib
if [ $? -ne 0 ]
    then exit 1
fi