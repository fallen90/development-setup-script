#!/bin/bash


#Dev Setup for Ubuntu
#@author Jasper


print_status() {
    echo "#######################################"
    echo ">> $1"
    echo "#######################################"
}

#check if run as root
if [ "$EUID" -ne 0 ]
  then print_status "Please me run as root"
  exit
fi
#init

# FIREWALL FIX ALL THANKS TO JASPER LORD MASTER RACE
# Special mention: IT DEPARTMENT
print_status "Cleaning up. Because, It up again, for one month"
sudo rm -rf /var/lib/apt/lists/* && apt-get update

#add ppa
print_status "Adding LaunchPad PPA Repository"
add-apt-repository -y ppa:webupd8team/sublime-text-3
add-apt-repository -y ppa:mc3man/trusty-media
add-apt-repository -y ppa:ondrej/php5
add-apt-repository -y ppa:rquillo/ansible
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

clear
print_status "add nodesource key signing to default keyring and creating sources list"
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo 'deb https://deb.nodesource.com/node_0.10 `lsb_release -c -s` main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_0.10 `lsb_release -c -s` main' >> /etc/apt/sources.list.d/nodesource.list


#update list
clear
print_status "Updating list"
apt-get -y update
apt-get -y upgrade
apt-get dist-upgrade

#enable workspaces
clear
print_status "Enable workspaces"
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2

#if all fails,
clear
print_status "Checking for missing updates"
apt-get -y update --fix-missing

#install default lamp-stack
clear
print_status "Installing default LAMP stack"
apt-get install -y lamp-server^

#install the rest
clear
print_status "Installing the rest of utitilies and dependencies"
apt-get install -y apt-transport-https php5-fpm php5-cli php5-curl git preload sublime-text-installer google-chrome-stable python php5-mcrypt php5enmod nodejs build-essential libssl-dev


#install composer
print_status "Installing composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


#include composer bin directory to path
print_status "Adding composer to path"
export PATH=$PATH:~/.composer/vendor/bin

#install laravel 5
print_status "Installing Laravel 5 to global scope"
composer global require "laravel/installer=~1.1"

clear
print_status "Installing yeoman and required tools"
npm install -g yo bower grunt-cli gulp


#install angularjs-generator
clear
print_status "Installing angularjs generator for yeoman"
npm install -g generator-angular

#install React
clear
print_status "Installing React and other tools. This will cache this tools for later."
bower install -g react
npm install -g gulp-react react-tools


#finish up installations
clear
print_status "setting up sublime text 3"
#install package control for sublime text 3
#kill all instances of sublime
killall sublime_text
cd "`find ~/ -name "sublime-text-3"`"
cd "`find .. -name "Installed Packages"`"
wget https://packagecontrol.io/Package%20Control.sublime-package
chmod 755 "Package Control.sublime-package"
#download sublime settings and other preferences
cd "`find .. -name "HTML-CSS-JS Prettify"`"
wget https://raw.githubusercontent.com/fallen90/sublime-settings/master/.jsbeautifyrc --output-document=".jsbeautifyrc"
chmod 755 ".jsbeautifyrc"
cd "`find .. -name "JSHint Gutter"`"
wget https://raw.githubusercontent.com/fallen90/sublime-settings/master/.jshintrc --output-document=".jshintrc"
chmod 755 ".jshintrc"
cd "`find .. -name "User"`"
wget https://raw.githubusercontent.com/fallen90/sublime-settings/master/Package%20Control.sublime-settings --output-document="Package Control.sublime-settings"
chmod 755 "Package Control.sublime-settings"


clear
print_status "Installing NVM"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
nvm 0.12

clear
print_status "Setup done, if there are errors, please rerun installer. Will reboot in 10 seconds"
for i in {20..1}
do
   clear
   echo "Installation done! Rebooting in $i seconds"
   sleep 1
done
print_status "Reboot!"
reboot
