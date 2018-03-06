# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.node_modules_global/bin:$PATH"

# Docker Machine start up using vmware
docker_running=$(docker-machine ls | grep dev)
if [[ "$docker_running" == *"Stopped"* ]]
then
	echo "*ERROR* Docker machine dev not running. Attempting to start it..."
	docker-machine start dev 
	eval "$(docker-machine env dev)"	
elif [[ "$docker_running" == *"Running"* ]]
then
	eval $(docker-machine env dev)
fi

