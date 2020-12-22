#!/usr/bin/env bash
# create a 1Gig swapfile
red='\033[0;31m'
yellow='\033[1;33m'  
NC='\033[0m' # No Color
printf "\nThis script creates a 1G Swap file.  \nIf you see something like Swap:  0  0  0 in yellow below -  \nthen you do NOT currently have a swap file."
echo -e "${yellow}-----------Swap info---------------"
free -m
echo "-----------------------------------"
echo -e "${red}"
read -p " Please press Y to continue, or N to stop" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo fallocate -l 1G /swapfile
	ls -lh /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	sudo swapon -s
	#sudo nano /etc/fstab
	echo -e "${yellow}-------Current contents of /etc/fstab--------"
	cat /etc/fstab
	echo "---------------------------------------------"
	echo -e "${red}"
	read -p "Would you like to add info to the fstab file to make the swap file permanent? (y/n)"
	echo -e "${NC}"
	if [[ $REPLY =~ ^[Yy]$ ]]
		then
			echo "adding swap info to /etc/fstab..."
			echo -e "\n/swapfile   none    swap    sw    0   0" >>/etc/fstab
			echo
	fi
	echo -e "${yellow}-----------Swap info---------------"
	free -m
	echo "-----------------------------------"
	echo -e "${red}"
	printf "IMPORTANT! About to Reboot to implement this immediately - Are you sure?\n"
	read -p "(If you press N, the swap file creation will have happened, but will not be used until you reboot)" -n 1 -r
	printf "\n"
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	   reboot
	fi

fi
echo -e "${NC}"
