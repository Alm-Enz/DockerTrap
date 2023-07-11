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

hostnamectl set-hostname debservstorage.deceptive.local
echo '$(hostname -I | awk "{print $1}" debservstorage.deceptive.local debservstorage)' >> /etc/hosts
echo '192.168.89.130 ad.deceptive.local ad)' >> /etc/hosts
sed -i 's/pool/#pool/' /etc/ntp.conf
echo /tmp/LDAP/ntp.conf >> /etc/ntp.conf

systemctl stop unscd
systemctl disable unscd
rm /var/run/nscd/socket
rm /etc/krb5.conf
cp /tmp/LDAP/krb5.conf /etc/krb5.conf

systemctl stop nmbd
systemctl disable nmbd
systemctl disable samba
systemctl disable samba-ad-dc

rm /etc/samba/smb.conf
cp /tmp/LDAP/smb.conf /etc/samba/smb.conf

systemctl restart smbd
systemctl enable smbd

cp /tmp/LDAP/sssd.conf /etc/sssd/sssd.conf
chmod 0600 /etc/sssd/sssd.conf
sed -i 's/passwd/passwd: compat sss #/' /etc/nsswitch.conf
sed -i 's/group/group: compat sss #/' /etc/nsswitch.conf
sed -i 's/netgroup/netgroup: nis sss #/' /etc/nsswitch.conf
echo 'sudoers: files' >> /etc/nsswitch.conf

cp /tmp/LDAP/pam-ad /usr/share/pam-configs/my-ad
/usr/sbin/pam-auth-update --package

cp /tmp/LDAP/ad-linux-admins /etc/sudoers.d/ad-linux-admins
cp /tmp/LDAP/join-ad.sh .
chmod +x join-ad.sh
bash join-ad.sh