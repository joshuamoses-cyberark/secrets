#!/bin/bash

username="admin"
password="password"
hostname="127.0.0.1"
secret="jenkins/jenkins/db_password"
account="myorg"
echo "Logging into Conjur"
login=$(curl -s -k --user $username:$password https://$hostname/authn/$account/login)
echo "Login information = $login"
echo "---------------------------"
echo "Getting Authentication Token"
auth=$(curl -s -k -H "Content-Type: text/plain" -X POST -d "$login" https://$hostname/authn/$account/$username/authenticate)
echo "Authentication Token is:"
echo "$auth"
echo "---------------------------"
echo "Formatting Token"
auth_token=$(echo -n $auth | base64 | tr -d '\r\n')
echo "Formatted Token"
echo "$auth_token"
echo "---------------------------"
echo "Retrieving $secret"
retrieve=$(curl -s -k -X GET -H "Authorization: Token token=\"$auth_token\"" https://$hostname/secrets/$account/variable/$secret)
echo "The SECRET value is $retrieve"
