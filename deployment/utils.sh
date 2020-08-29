# Exits the script with a message and exit code 1
function error_exit
{
    echo "$1" 1>&2
    exit 1
}

# check if root user is selected
function check_root
{
    if [ "$EUID" -ne 0 ]; then
	echo "##################"
        echo "Please run as root"
	echo "##################"
        exit
    fi
}

