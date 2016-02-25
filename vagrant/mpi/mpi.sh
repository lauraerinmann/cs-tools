#!/bin/sh

echo "[i] Setting up MPI dependencies"

SETUP=/vagrant/share/setup

## install dependencies
sudo yum -q -y install mpich
sudo yum -q -y install mpich-devel
