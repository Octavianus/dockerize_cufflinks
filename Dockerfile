### Dockerized cufflinks version 2.2.1
# use the dockerfile/python base image
FROM dockerfile/python

MAINTAINER David Weng weng@email.arizona.edu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

### get the lib that needed for compiling by the fastx.
## Step 1: Install the basic tools to set up the environment.
# Install the wget, gcc, make tools, handling the lib dependency problem.
RUN apt-get install -y wget
RUN apt-get install -y gcc g++
RUN apt-get install -y make

## Step 2: Install the binary file instead of configure, make and make install because that would cause a series of library dependency problems. Never try to do that.
WORKDIR /home/vagrant
RUN wget http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN tar xvzf cufflinks-2.2.1.Linux_x86_64.tar.gz

## Step 3: Add the executable to PATH.
## Or change the CMD and ENTRYPOINT, we use the formmer here.

### This is a bug of Docker, &PATH cannot being changed.
#WORKDIR /home/vagrant
#RUN PATH=$PATH:/home/vagrant/cufflinks-2.2.1.Linux_x86_64
#RUN export PATH
# ENTRYPOINT ["/home/vagrant/cufflinks-2.2.1.Linux_x86_64/cuffdiff"]

### A way to solve this bug is use the ENV feature:
# The ENV instruction sets the environment variable <key> to the value <value>. This value will be passed to all future RUN instructions. We can change them during the docker run --eve <key>=<value>.
ENV PATH /home/vagrant/cufflinks-2.2.1.Linux_x86_64:$PATH
