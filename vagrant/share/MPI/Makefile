CC = /usr/lib64/mpich/bin/mpicc

CFLAGS = -I. -g -Wall
LDFLAGS = -L. -lm

default: all
all: hello potato

.PHONY: clean

%.o:%.cc $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

hello: hello.o
	$(CC) -o $@ $^ $(LDFLAGS)

potato: potato.o
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	/bin/rm -f *.o hello potato

squeaky: clean
	/bin/rm -f *~ *.bak
