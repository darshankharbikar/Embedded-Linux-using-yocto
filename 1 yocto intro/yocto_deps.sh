#!/bin/bash

set -e

echo "Updating package lists..."
sudo apt update -y
sleep 3

echo "Upgrading installed packages..."
sudo apt upgrade -y
sleep 3

packages=(
    gawk
    wget
    git-core
    diffstat
    unzip
    texinfo
    gcc-multilib
    build-essential
    chrpath
    socat
    cpio
    python3
    python3-pip
    python3-pexpect
    xz-utils
    debianutils
    iputils-ping
    python3-git
    python3-jinja2
    libegl1-mesa
    libsdl1.2-dev
    pylint3
    xterm
)

for pkg in "${packages[@]}"
do
    echo "Installing $pkg..."
    sudo apt install -y "$pkg"
    sleep 3
done

echo "All packages installed successfully."
