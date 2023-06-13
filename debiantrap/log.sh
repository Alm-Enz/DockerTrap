#!/bin/bash
dock_ip="$@"
 
facility=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $2}')
dock_ip_formated=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $1}')
msg=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $3}'| rev | cut -c5- | rev)
 
if [[ "$msg" == *"omfwd: remote server at"* ]]
then
        true
else
        remote_ip=$(docker ps -qa | xargs -n 1 docker inspect --format '{{ .Name }}{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##' | grep $dock_ip_formated |cut -d' ' -f1 | cut -c10-)
        mkdir /var/log/HP/$remote_ip
        echo "REMOTE_IP="$remote_ip"            MSG="$msg >>/var/log/HP/$remote_ip/$facility
fi
