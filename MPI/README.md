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

* Download from vagrantup.com the latest version of vagrant software for your operating system.
* Download from virtualbox.org the latest version of virtualbox software for your operating system.

## Setup your compute nodes

* Create a project directory: `mini-cluster`

### Preparing node1

* Create a node directory: `mkdir node1`
* Initialize a vagrant node: 
```
cd node1
vagrant init puphpet/centos65-x64
```
This process will take awhile the first time around.
4. Update the `Vagrantfile` by adding the following lines
```
  config.vm.hostname = "node1"
  config.vm.network "private_network", ip: "192.168.33.1"
```
after the line `config.vm.box = "puphpet/centos65-x64"`
* Spin up your **node1** instance: `vagrant up`
   * You might have to run provision if you get the message
```
Machine already provisioned. Run `vagrant provision` or use the `--provision`
```
* Login into your virtual os:
   * If your host os is OSX or Linux you can simply type: `vagrant ssh`
   * If your host os is Windows you'll need to run `putty.exe`
* Install mpich 3.4.1: `sudo yum -y install mpich mpich-devel`
* Generate your ssh key (you can default `enter` on all options):
```
ssh-keygen -t rsa
cd ~/
tar cvfz /vagrant/ssh-keys.tar.gz .ssh
cd ~/.ssh
cat id_rsa.pub >> authorized_keys
chmod 600 authorized_keys
```
* Exit the virtual environment: `exit`

## Preparing node2

* Create directory and initialize another vagrant node:
```
cd ..
mkdir node2
vagrant init puphpet/centos65-x64
```
* Update your `Vagrantfile` by adding the following lines
```
  config.vm.hostname = "node2"
  config.vm.network "private_network", ip: "192.168.33.2"
```
after the line `config.vm.box = "puphpet/centos65-x64"`
* Copy your keys file to the working directory: `cp ../node1/ssh-keys.tar.gz .`
* Spin up your **node2**: `vagrant up`
* Login into your virtual os
* Install mpich 3.4.1: `sudo yum -y install mpich mpich-devel`
* Unpack your keys and install mpich software:
```
tar xvfz /vagrant/ssh-keys.tar.gz
sudo yum install mpich mpich-devel
cd ~/.ssh
cat id_rsa.pub >> authorized_keys
chmod 600 authorized_keys
```
* Exit the virtual environment: `exit`

Note that you can repeat the above steps for `node3` and `node4`

### Writing your first MPI program

For the following example program , do all your execution on `node1` and out of the `/vagrant` directory.  

Create a program `hello.c` with the following code:

```
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

int printTime()
{
  time_t current_time;
  char* c_time_string;

  current_time = time(NULL);

  if (current_time == ((time_t)-1)) {
    fprintf(stderr, "Failure to obtain the current time.\n");
    return EXIT_FAILURE;
  }

  c_time_string = ctime(&current_time);

  if (c_time_string == NULL) {
    fprintf(stderr, "Failure to convert the current time.\n");
    return EXIT_FAILURE;
  }

  printf("Current time is %s", c_time_string);

  return EXIT_SUCCESS;
}

int main(int argc, char** argv) 
{
  // Initialize the MPI environment
  MPI_Init(NULL, NULL);

  // Get the number of processes
  int world_size;
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);

  // Get the rank of the process
  int world_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

  // Get the name of the processor
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);

  printTime();

  // Print off a hello world message
  printf("Hello world from processor %s, rank %d"
         " out of %d processors\n",
         processor_name, world_rank, world_size);

  // Finalize the MPI environment.
  MPI_Finalize();

  return 0;
}
```

To compile the program run the following command:

```
/usr/lib64/mpich/bin/mpicc -o hello hello.c
```

Create `hostfile` with the following content:

```
192.168.33.1
```

To run your program execute the following command:

```
/usr/lib64/mpich/bin/mpirun -n 4 -f hostfile /vagrant/hello
```


