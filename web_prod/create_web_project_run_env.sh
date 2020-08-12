#!/bin/bash
#
# Usage:
#	$ create_web_project_run_env <appname>

source ./utils.sh

check_root

GROUPNAME=gs_2
USERNAME=gs_2

APPFOLDER=gsshop
APPFOLDERPATH=/$GROUPNAME/$APPFOLDER

# ###################################################################
# Create the app folder
# ###################################################################
echo "Creating app folder '$APPFOLDERPATH'..."
mkdir -p /$GROUPNAME/$APPFOLDER || error_exit "Could not create app folder"

# test the group 'gs' exists, and if it doesn't create it
getent group $GROUPNAME
if [ $? -ne 0 ]; then
    echo "Creating group '$GROUPNAME' for automation accounts..."
    groupadd --system $GROUPNAME || error_exit "Could not create group 'webapps'"
fi

# create the app user account, same name as the appname
grep "$USERNAME:" /etc/passwd
if [ $? -ne 0 ]; then
    echo "Creating user account '$USERNAME'..."
    useradd --system --gid $GROUPNAME --shell /bin/bash $USERNAME || error_exit "Could not create automation user account '$USERNAME'"
fi

# change ownership of the app folder to the newly created user account
echo "Setting ownership of $APPFOLDERPATH and its descendents to $USERNAME:$GROUPNAME..."
chown -R $USERNAME:$GROUPNAME $APPFOLDERPATH || error_exit "Error setting ownership"
# give group execution rights in the folder;
# TODO: is this necessary? why?
chmod g+x $APPFOLDERPATH || error_exit "Error setting group execute flag"

echo "Creating environment setup for django app..."
su -l gs_2 << 'EOF'
pwd
python3.7 -m venv gsshop_env
EOF

