# HADOOP using Vagrant

This tutorial will walk students through the process of setting up a reasonable environment for Hadoop programming using [Vagrant](http://www.vagrantup.com).  

## Background

We will deploy a portable cluster with the following configuration:
* Four nodes running Linux CentOS 6.5
* Hadoop 1.2.1 (this is quiet old but sufficient for what what want to do!)

## Install Pre-Requisites

* Download the latest version of [vagrant] software for your operating system.
* Download the latest version of [VirtualBox](http://virtualbox.org) software for your operating system.

## Start compute nodes

```
vagrant ssh node1
cd /vagrant/wordcount
hadoop namenode -format
start-all.sh
hadoop dfs -copyFromLocal gutenberg/ /user/vagrant/gutenberg
hadoop dfs -ls /user/vagrant/gutenberg

hadoop jar /opt/hadoop-1.2.1/hadoop-examples-*.jar \
   wordcount /user/vagrant/gutenberg \
   /user/vagrant/gutenberg-out

hadoop dfs -copyToLocal /user/vagrant/gutenberg-out out
```

## Writing your own c++ hadoop programming

This part will require that you have the cluster setup correctly.

```
cd /vagrant/wordcount
make
sh run.sh
hadoop dfs -ls 
hadoop dfs -copyToLocal dft1-out dft1-out
```

You can now examine the content of `dft1-out` and the result should match `out`.
