
CC = g++
HADOOP_INSTALL = /opt/hadoop-1.0.3
PLATFORM = Linux-amd64-64
CPPFLAGS = -I$(HADOOP_INSTALL)/c++/$(PLATFORM)/include  

wordcount: wordcount.cpp
	$(CC) $(CPPFLAGS) $< -Wall -L$(HADOOP_INSTALL)/c++/$(PLATFORM)/lib -lhadooppipes -lhadooputils -lpthread -lcrypto -lssl -g -O2 -o $@

clean:
	/bin/rm -f wordcount
