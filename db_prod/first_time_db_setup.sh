#!/usr/bin/env bash

source ./first_time_db_setup.sh

DB=$1
USER=$2
PASSWORD=$3

echo "Accessing postgres console :"
sudo -u postgres psql
echo "Creating database....."
CREATE DATABASE $DB;
echo "Creating user while setting password....."
CREATE USER $USER WITH PASSWORD $PASSWORD;
echo "Making recommended setting changes....."
ALTER ROLE gs_db_user SET client_encoding TO 'utf8';
ALTER ROLE gs_db_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE gs_db_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE $DB TO $USER;

"""
Manual changes -->

1. sudo vim /etc/hosts ( add this entry)
    10.0.1.79 web.prod 
    10.0.3.18 db.prod

2. sudo vim /etc/postgresql/10/main/postgresql.conf 

    listen_addresses = 'db.prod,localhost'

3.  sudo vim /etc/postgresql/10/main/pg_hba.conf

     host    gs_db           myprojectuser   web.prod              md5
"""