#!/usr/bin/env bash

#Make sure to have your /etc/sudoers file has these lines appended
#
#%sudo ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get update
#%sudo ALL=(ALL:ALL) NOPASSWD: /usr/bin/unattended-upgrade
#%sudo ALL=(ALL:ALL) NOPASSWD: /usr/sbin/reboot


#List of Servers; You can add as many as you want, just make sure $user has access too above commands
# 1: LABEL 2: LABEL
srvlist=( "255.255.255.255" "255.255.255.255"  )

#SSH Admin Username
user=$1


#variables needed for code
string="No packages found that can be upgraded unattended and no pending auto-removals"

for server in ${srvlist[@]}; do
        echo "Working on $server"
        ssh -i ~/.ssh/id_rsa -tt $user@$server '
              
		if [ ! -f logfile.txt ]; then
                        touch logfile.txt
                fi
                
		if [ ! -d ./updatelogs/ ]; then
			mkdir ./updatelogs/
		fi

                sudo apt-get update && sudo unattended-upgrade >> logfile.txt
                
		if grep -wq "$string" logfile.txt; then
			mv logfile.txt ./updatelogs/$(date +"%m-%d-%Y").log
                        echo Restarting $server
			sudo reboot now
                else
			mv logfile.txt ./updatelogs/$(date +"%m-%d-%Y").log
			echo "No update; No reboot"
		fi'
	done

