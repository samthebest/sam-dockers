FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get -y install wget nano less sudo curl ssh openssl git

RUN apt-get install -y software-properties-common

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

ADD start-mysql-properly.sh /root/start-mysql-properly.sh

# Still doesn't work, still have to start again when ssh in
RUN /root/start-mysql-properly.sh

RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# to run a mysql shell: service mysql start && mysql -u root --password=password
