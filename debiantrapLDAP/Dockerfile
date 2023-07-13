#SSH Server
#VERSION 0.0.1

#Base Image Debian11
FROM debian:bullseye

#Maintainer Info.
#MAINTAINER Almond CWATCH

#Update APT repository & Install OpenSSH
RUN apt-get update \
    && apt-get install -y openssh-server \
   # && apt-get install -y mysql-client \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq rsyslog ntp krb5-user samba samba-common sssd iputils-ping
#Establish the operating directory of OpenSSH
RUN mkdir /var/run/sshd
RUN service rsyslog start
#RUN service rsyslog stop
#Set Root password
RUN echo 'root:hellossh' | chpasswd
#Allow Root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    /etc/ssh/sshd_config

#SSH login fix
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional \
    pam_loginuid.so@g' -i /etc/pam.d/sshd

#Copy all required files
RUN mkdir /tmp/LDAP
COPY LDAP/ /tmp/LDAP
COPY LDAP/resolv.conf /root/
#COPY ntp.conf /tmp/LDAP/
#COPY krb5.conf /tmp/LDAP/
#COPY join-ad.sh /tmp/LDAP/
#COPY pam-ad /tmp/LDAP/
#COPY smb.conf /tmp/LDAP/
#COPY sssd.conf /tmp/LDAP/
#COPY ad-linux-admins /tmp/LDAP/

COPY start.sh /tmp/
RUN sudo bash /tmp/start.sh

RUN rm /tmp/start.sh
CMD source /root/.bashrc
CMD /bin/bash -c "source /root/.bashrc"
CMD source /root/.profile
CMD /bin/bash -c "source /root/.profile"
RUN  su -c "ls" root

#expose port 22
EXPOSE 22

#Commands to be executed by default
CMD ["/usr/sbin/sshd","-D"]
