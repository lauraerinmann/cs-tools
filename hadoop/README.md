# HADOOP using Vagrant

This tutorial will walk students through the process of setting up a reasonable environment for Hadoop programming using [Vagrant](http://www.vagrantup.com).  

## Background

We will deploy a portable cluster with the following configuration:
* Four nodes running Linux CentOS 6.5
* Hadoop 1.2.1 (this is quiet old but sufficient for what what want to do!)

## Install Pre-Requisites

* Download the latest version of [vagrant] software for your operating system.
* Download the latest version of [VirtualBox](http://virtualbox.org) software for your operating system.

## Start a compute node

```
vagrant up node1 --provision
vagrant ssh node1
hadoop namenode -format
start-all.sh
```

For windows users please putty into the host and port shown with the `vagrant up node1 --provision` output.

## Run java `wordcount` program

```
hadoop dfs -copyFromLocal gutenberg/ /user/vagrant/gutenberg
hadoop dfs -ls /user/vagrant/gutenberg

hadoop jar /opt/hadoop-1.2.1/hadoop-examples-*.jar \
   wordcount /user/vagrant/gutenberg \
   /user/vagrant/gutenberg-out

hadoop dfs -ls /user/vagrant/gutenberg-out
hadoop dfs -copyToLocal /user/vagrant/gutenberg-out out
```

The output files should be copied to `out` folder.

## Writing your own c++ hadoop programming

```
cd /vagrant/wordcount
make
sh run.sh
hadoop dfs -ls dft1-out
hadoop dfs -copyToLocal dft1-out dft1-out
```

You can now examine the content of `dft1-out` and the result should match `out`.
