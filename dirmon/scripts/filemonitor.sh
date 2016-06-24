#!/bin/sh
. $(dirname $0)/../env.properties
BDRE_HOME=~/bdre
BDRE_APPS_HOME=~/bdre_app
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] ; then
        echo Insufficient parameters !
        exit 1
fi
busDomainId=$1
processTypeId=$2
processId=$3
userName=$4
echo $0
#creating flume command for
nohup java -cp "$BDRE_HOME/lib/file-mon/*" com.wipro.ats.bdre.filemon.FileMonRunnableMain -p $processId -u $userName &