#!/bin/bash

source ./utils.sh

check_root

LINUX_PREREQ=('git' 'build-essential' 'supervisor' 'libpq-dev' 'python3.7-dev' 'python3.7-venv' 'python3-pip' 'nginx' 'ufw')

# Test prerequisites
echo "Checking if required packages are installed..."
declare -a MISSING

for pkg in "${LINUX_PREREQ[@]}"
    do
        echo "Installing '$pkg'..."
        apt-get -y install $pkg
        if [ $? -ne 0 ]; then
            echo "Error installing system package '$pkg'"
            exit 1
        fi
    done


if [ ${#MISSING[@]} -ne 0 ]; then
    echo "Following required packages are missing, please install them first."
    echo ${MISSING[*]}
    exit 1
fi

echo "All required packages have been installed!"
