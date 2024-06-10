# VMupdater
Simple script that auto updates, restarts(as needed), then logs everything in a file to as many servers as you want.
INTENDED FOR UBUNTU SERVER 22

Make sure to have your /etc/sudoers file has these lines appended
%sudo ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get update
%sudo ALL=(ALL:ALL) NOPASSWD: /usr/bin/unattended-upgrade
%sudo ALL=(ALL:ALL) NOPASSWD: /usr/sbin/reboot
