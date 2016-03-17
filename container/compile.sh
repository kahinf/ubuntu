#!/bin/bash

set -e
set -u

# Variables
TIMEZONE='Europe/London'

# Enable Ubuntu Multiverse.
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

# Update repos 
apt-get update
    
## Install HTTPS support for APT
apt-get install -yq --no-install-recommends apt-transport-https ca-certificates

## Install add-apt-repository
apt-get install -yq --no-install-recommends software-properties-common

# Upgrade all packages
apt-get dist-upgrade -y --no-install-recommends

# Often used tools
apt-get install -yq --no-install-recommends \
    mc \
    less \
    vim \
    nano \
    wget \
    curl \
    git-core \
    openssh-client \
    bash-completion

# Supervisor installation && set nodaemon to true
apt-get install -yq --no-install-recommends supervisor
sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Bash git completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
echo 'source ~/.git-prompt.sh' >> ~/.bashrc

# Force color bash prompt
sed -i "s/#force_color_prompt=yes/force_color_prompt=yes/" ~/.bashrc

# Enable bash completion
echo "\n# Enable programmable completion features" >> ~/.bashrc
echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then' >> ~/.bashrc
echo '    . /etc/bash_completion' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

# Configure system timezone
echo $TIMEZONE > /etc/timezone; dpkg-reconfigure tzdata

# hstr repo
export LANG=C.UTF-8
add-apt-repository ppa:ultradvorka/ppa

# Update & install hh
apt-get update
apt-get install -yq --no-install-recommends hh
    
# Clean up the mess
apt-get autoclean
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*