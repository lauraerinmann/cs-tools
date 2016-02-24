# Add /opt/hadoop-1.0.3/bin to the path for sh compatible users

if ! echo $PATH | grep -q /opt/hadoop-1.0.3/bin ; then
  export PATH=$PATH:/opt/hadoop-1.0.3/bin
fi
