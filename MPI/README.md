# MPI using Vagrant

This tutorial will walk students through the process of setting up a reasonable environment for MPI programming using [Vagrant](http://www.vagrantup.com).  

## Background

We will deploy a portable cluster with the following configuration:
* Four nodes running Linux CentOS 6.5
* mpich 3.4.1 MPI software

The compute nodes will talk to each other using a private host-only network setup using the following network configuration.
```
node1 192.168.33.1
node2 192.168.33.2
node3 192.168.33.3
node4 192.168.33.4
```

## Install Pre-Requisites

1. Download from vagrantup.com the latest version of vagrant software for your operating system.

2. Download from virtualbox.org the latest version of virtualbox software for your operating system.

## Setup your compute nodes

1. Create a project directory: `mini-cluster`

### Preparing node1

2. Create a node directory: `mkdir node1`
3. Initialize a vagrant node: 
```
cd node1
vagrant init chef/centos-6.5
```
This process will take awhile the first time around.
4. Update the `Vagrantfile` by adding the following lines
```
  config.vm.hostname = "node1"
  config.vm.network "private_network", ip: "192.168.33.1"
```
after the line `config.vm.box = "chef/centos-6.5"`
5. Spin up your **node1** instance: `vagrant up`
6. Login into your virtual os:
   * If your host os is OSX or Linux you can simply type: `vagrant ssh`
   * If your host os is Windows you'll need to run `putty.exe`
7. Install mpich 3.4.1: `sudo yum -y install mpich mpich-devel`
8. Generate your ssh key (you can default `enter` on all options):
```
ssh-keygen -t rsa
cd ~/
tar cvfz /vagrant/ssh-keys.tar.gz .ssh
cd ~/.ssh
cat id_rsa.pub >> authorized_keys
chmod 600 authorized_keys
```
9. Exit the virtual environment: `exit`

## Preparing node2

10. Create directory and initialize another vagrant node:
```
cd ..
mkdir node2
vagrant init chef/centos-6.5
11. Update your `Vagrantfile` by adding the following lines
```
  config.vm.hostname = "node2"
  config.vm.network "private_network", ip: "192.168.33.2"
```
after the line `config.vm.box = "chef/centos-6.5"`
12. Copy your keys file to the working directory: `cp ../node1/ssh-keys.tar.gz .`
13. Spin up your **node2**: `vagrant up`
14. Login into your virtual os
15. Install mpich 3.4.1: `sudo yum -y install mpich mpich-devel`
16. Unpack your keys and install mpich software:
```
tar xvfz /vagrant/ssh-keys.tar.gz
sudo yum install mpich mpich-devel
cd ~/.ssh
cat id_rsa.pub >> authorized_keys
chmod 600 authorized_keys
```
17. Exit the virtual environment: `exit`

Note that you can repeat the above steps for `node3` and `node4`

