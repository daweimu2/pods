# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ninja-build \
        cmake \
        git \
        curl \
        libcurl4-openssl-dev \
        rsync \
        pipx \
        ssh \
        wget \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://artifactory-cdn.amd.com/artifactory/list/amdgpu-deb/amdgpu-install-internal_6.5-24.04-1_all.deb
RUN apt-get install ./amdgpu-install-internal_6.5-24.04-1_all.deb
RUN amdgpu-repo --amdgpu-build=2156314 --rocm-build=compute-rocm-dkms-no-npi-hipclang/15905
RUN amdgpu-install -y --usecase=rocm

RUN pipx install conan

