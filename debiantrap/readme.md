# Procedure (Debian11)
~~~ shell
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt -y install socat xinetd auditd netcat-openbsd git docker-ce
git clone https://github.com/mrhavens/DockerTrap
~~~

nano /etc/services -> ssh 2222/tcp et honeypot 22/tcp

~~~ shell
cd DockerTrap  
cp honeypot/h* /usr/bin/
cp xinted.d/honeypot /etc/xinetd.d/honeypot
systemctl restart xinetd
docker build -t honeypot:latest .
echo "*/5 * * * * root /usr/bin/honeypot.clean" >> /etc/crontab
cp log.sh /usr/local/bin/
chmod 775 /usr/local/bin/log.sh
~~~

copy rsyslog.conf lines to /etc/rsyslog.conf


~~~ shell
sudo systemctl restart rsyslog
~~~
# Penser à créer index HoneyPot sur SplunkServer
# Install splunk forwarder and config
~~~ shell
wget https://download.splunk.com/products/universalforwarder/releases/9.0.4/linux/splunkforwarder-9.0.4-de405f4a7979-linux-2.6-amd64.deb

dpkg -i splunkforwarder-9.0.4-de405f4a7979-linux-2.6-amd64.deb
/opt/splunkforwarder/bin/splunk enable boot-start 
/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes

/opt/splunkforwarder/bin/splunk add monitor /var/log/remote -index HoneyPot -sourcetype Dockertrap
/opt/splunkforwarder/bin/splunk add forward-server hostname:9997
~~~
