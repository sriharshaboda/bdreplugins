#!/bin/bash

td_query_file=$1

ssh tduser@10.0.0.11 "query-runner-local.sh $td_query_file dbc zaq1xsw2 localhost"
exit $?