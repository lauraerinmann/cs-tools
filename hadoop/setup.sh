#!/bin/sh

## install dependencies
for f in openssl-devel mpich mpich-devel java-1.7.0-openjdk-devel
  sudo yum -q -y install ${f}
done

## update etc
sudo install -m 644 -o root /vagrant/etc/hosts /etc/hosts

## install hadoop
curl --silent --output /tmp/hadoop.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-1.0.3/hadoop-1.0.3-bin.tar.gz
sudo tar -zxf /tmp/hadoop.tar.gz -C /opt
cp /vagrant/hadoop/* /opt/hadoop-1.0.3/conf/
sudo mkdir -p /app/hadoop/tmp
sudo chown vagrant /app/hadoop/tmp
sudo chmod 750 /app/hadoop/tmp
sudo chown -R vagrant /opt/hadoop-1.0.3

## setup keys
install -m 600 -o vagrant /vagrant/ssh/id_rsa ~vagrant/.ssh/id_rsa
install -m 600 -o vagrant /vagrant/ssh/config ~vagrant/.ssh/config
cat /vagrant/ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys

## setup paths
for f in mpich.sh hadoop.sh java.sh; do
  sudo install -m 644 /vagrant/profile.d/${f} /etc/profile.d/
done
