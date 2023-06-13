#!/bin/bash


echo '*.debug;mail.none;authpriv.none;cron.none          /var/log/syslog' >> /etc/rsyslog.conf
echo 'echo "IGV4cG9ydCBQUk9NUFRfQ09NTUFORD0nUkVUUk5fVkFMPSQ/O2xvZ2dlciAtcCBsb2NhbDYuZGVidWcgIiQod2hvYW1pKSBbJCRdOiAkKGhpc3RvcnkgMSB8IHNlZCAicy9eWyBdKlswLTldXCtbIF0qLy8iICkgWyRSRVRSTl9WQUxdIic=" | base64 -d'  > /etc/bashrctemp
cat /etc/bashrctemp | sh >> /etc/bashrc

echo 'module(load="imtcp")' >> /etc/rsyslog.conf
echo 'input(type="imtcp" port="514")' >> /etc/rsyslog.conf
#echo 'local6.* /var/log/commands.log' >> /etc/rsyslog.d/commands.conf
echo 'local6.* /var/log/commands.log' >> /etc/rsyslog.conf
echo '/var/log/commands.log' >> /etc/logrotate.d/rsyslog
echo '. /etc/bashrc' >> ~/.bashrc
echo '\n' >> /etc/bashrc
echo 'PrintLastLog no' >> /etc/ssh/ssh_config

echo 'service rsyslog stop > /dev/null 2>&1' >> /etc/bashrc
echo 'service rsyslog start > /dev/null 2>&1' >> /etc/bashrc
echo 'service rsyslog stop > /dev/null 2>&1' >> /etc/profile
echo 'service rsyslog start > /dev/null 2>&1' >> /etc/profile
echo 'service rsyslog stop > /dev/null 2>&1' >> /root/.profile
echo 'service rsyslog start > /dev/null 2>&1' >> /root/.profile
echo '*.* @@172.17.0.1:514' >> /etc/rsyslog.conf
service rsyslog restart > /dev/null 2>&1
