#!/bin/bash
dock_ip="$@"
 
facility=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $2}')
dock_ip_formated=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $1}')
msg=$(echo $dock_ip | awk 'BEGIN {FS="<DELIM>";}{print $3}')
#echo "msg="$msg" & facility="$facility >> /tmp/test
#dock_ip_formated=$(echo $dock_ip | cut -d'/' -f5)
 
if [[ "$msg" != *"omfwd: remote server at"*  ]]; then
        remote_ip=$(docker ps -qa | xargs -n 1 docker inspect --format '{{ .Name }}{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##' | grep $dock_ip_formated |cut -d' ' -f1 | cut -c10-)
 
        echo $dock_ip >> /tmp/test
        #echo $( tail -n 1 /var/log/remote/$dock_ip_formated/local6)'           REMOTE_IP=$remote_ip' >>/var/log/HP/$remote_ip/commands
        mkdir /var/log/HP/$remote_ip
        #sleep 10
        echo "REMOTE_IP="$remote_ip"            MSG="$msg >>/var/log/HP/$remote_ip/$facility
fi
