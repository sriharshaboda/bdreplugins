# Fetching Arguments

target_username=$2
target_password=$3
target_tpdid=$4
td_query=`cat $1` 

# Code Block to connect the DB and run the TD query. 

echo " Connecting to database $target_username -- $target_tpdid"

echo "executing the query :$td_query"

bteq<<EOF
.logon $target_tpdid/$target_username,$target_password;
.SET WIDTH 5000

$td_query;

.LOGOFF
EOF

exitstatus=$?

if [[ $exitstatus -ne 0 ]] 
then 
echo "Error Occurred."
echo "TD query ran and the output has been saved into output.txt file"
exit 1
fi 


echo "Query got executed successfully"
tduser@ip-10-0-0-11:~> 
tduser@ip-10-0-0-11:~> 
tduser@ip-10-0-0-11:~> 
tduser@ip-10-0-0-11:~> cat query-runner-local.sh
# Fetching Arguments

target_username=$2
target_password=$3
target_tpdid=$4
td_query=`cat $1` 

# Code Block to connect the DB and run the TD query. 

echo " Connecting to database $target_username -- $target_tpdid"

echo "executing the query :$td_query"

bteq<<EOF
.logon $target_tpdid/$target_username,$target_password;
.SET WIDTH 5000

$td_query;

.LOGOFF
EOF

exitstatus=$?

if [[ $exitstatus -ne 0 ]] 
then 
echo "Error Occurred."
echo "TD query ran and the output has been saved into output.txt file"
exit 1
fi 


echo "Query got executed successfully"