#!/bin/sh

export LIB=-lcrypto

## install dependencies
for f in openssl-devel mpich mpich-devel java-1.7.0-openjdk-devel; do
  sudo yum -y install ${f}
done

## update etc
sudo install -m 644 -o root /vagrant/etc/hosts /etc/hosts

## install hadoop
HADOOP=hadoop-1.2.1
curl --silent --output /tmp/hadoop.tar.gz https://archive.apache.org/dist/hadoop/common/$HADOOP/${HADOOP}.tar.gz
sudo tar -zxf /tmp/hadoop.tar.gz -C /opt

( cd /opt/hadoop-1.2.1/src/c++/utils ; sh configure ; make install )
( cd /opt/hadoop-1.2.1/src/c++/pipes ; sh configure ; make install )

cp /vagrant/hadoop/* /opt/${HADOOP}/conf/
sudo mkdir -p /app/hadoop/tmp
sudo chown -R vagrant /app/hadoop/tmp
sudo chown -R vagrant /opt/${HADOOP}
sudo chmod 750 /app/hadoop/tmp

## setup keys
install -m 600 -o vagrant /vagrant/ssh/id_rsa ~vagrant/.ssh/id_rsa
install -m 600 -o vagrant /vagrant/ssh/config ~vagrant/.ssh/config
cat /vagrant/ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys

## setup paths
for f in mpich.sh hadoop.sh java.sh; do
  sudo install -m 644 /vagrant/profile.d/${f} /etc/profile.d/
done
