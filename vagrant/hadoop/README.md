# HADOOP using Vagrant

[Hadoop](http://hadoop.apache.org) is a MapReduce system developed by the [Apache](http://apache.org) foundation.  This tutorial walks you through the process of setting up a vagrant cluster for development and experimentation.

## Single Node configuration

Start up your first single node:

```
cd cs-tools/hadoop
vagrant up node0 --provision
vagrant ssh node0
```

## Prepare the hadoop system

```
hadoop namenode -format
start-all.sh
```

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

## Run c++ `wordcount` program

```
cd /vagrant/wordcount
make
sh run.sh
hadoop dfs -ls dft1-out
hadoop dfs -copyToLocal dft1-out dft1-out
```

You can now examine the content of `dft1-out` and the result should match `out`.

# References

* [Running Hadoop on Ubuntu Linux (Single-Node Cluster)] (http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/)

* [Hadoop Tutorial 2.2 -- Running C++ Programs on Hadoop](http://www.science.smith.edu/dftwiki/index.php/Hadoop_Tutorial_2.2_--_Running_C++_Programs_on_Hadoop)
