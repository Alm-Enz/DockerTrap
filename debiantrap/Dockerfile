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
    && apt-get install -y rsyslog
#Establish the operating directory of OpenSSH
RUN mkdir /var/run/sshd
RUN service rsyslog start
#RUN service rsyslog stop
#Set Root password
RUN echo 'root:hellossh' | chpasswd
COPY start.sh /tmp/
RUN bash /tmp/start.sh
#Allow Root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    /etc/ssh/sshd_config

#SSH login fix
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional \
    pam_loginuid.so@g' -i /etc/pam.d/sshd
    
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
