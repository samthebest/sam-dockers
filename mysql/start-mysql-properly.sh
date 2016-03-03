#!/bin/bash

echo "[mysqld]" > /etc/my.cnf
echo "socket=/var/lib/mysqld/mysql.sock" >> /etc/my.cnf

service mysql start

mysqladmin -u root password password
