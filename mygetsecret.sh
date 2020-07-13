#!/bin/bash

master_name="127.0.0.1"
dap_name="myorg"
host_name="host%2Fjosh-laptop"
secret_name="jenkins%2Fjenkins%2Fdb_password"
api="1y29znx1qw4ve6121jmrn1n537tc1bnj7k12rjagr2jb4mx3a3r26w"
auth=$(curl -sk -H "Content-Type: text/plain" -d "$api" -X POST https://$master_name/authn/$dap_name/$host_name/authenticate)
auth_token=$(echo -n $auth | base64 | tr -d '\r\n')
#echo "$auth_token"
secret_retrieve=$(curl -sk -X GET -H "Authorization: Token token=\"$auth_token\"" https://$master_name/secrets/$dap_name/variable/$secret_name)
echo $secret_retrieve
