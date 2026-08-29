# Using Ubuntu base image 
FROM ubuntu:latest

# install necessary tools (grep, nano, vim, less)
RUN apt-get update && apt-get install -y \
    grep \
    nano \
    vim \
    less \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/my_app

# Copy sample files
COPY app.log /var/log/my_app/app.log

# Make default working directory
WORKDIR /var/log/my_app

# Open the container in interactive mode
CMD ["/bin/bash"]