# Using Ubuntu base image 
FROM ubuntu:26.04

# install necessary tools (grep, nano, vim, less)
RUN apt-get update && apt-get install -y \
    vim \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/application
RUN mkdir -p /etc/application

# Copy sample files
COPY log_files/* /var/log/application
COPY root_files/* /root
COPY etc_application/* /etc/application

# Make default working directory
WORKDIR /root