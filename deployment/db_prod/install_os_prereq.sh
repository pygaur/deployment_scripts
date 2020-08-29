#!/bin/bash

source .//utils.sh

check_root

LINUX_PREREQ=('postgresql' 'postgresql-contrib')

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

echo "All required packages have been installed!"
