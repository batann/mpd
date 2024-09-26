#!/bin/bash

########################################################################
###     mpd ncmpcpp and wildmidi configuration          ################
########################################################################


###   Function to detect the init system   ############################
get_init_system() {
    if [ -f /run/systemd/system ]; then
        echo "systemd"
    elif command -v service >/dev/null; then
        echo "SysVinit"
    elif command -v rc-service >/dev/null; then
        echo "OpenRC"
    elif command -v initctl >/dev/null; then
        echo "Upstart"
    else
        echo "unknown"
    fi
}

###   get init  system type            ##############################
local init_system=$(get_init_system)  # Detect the init system

###   Install dependencies if any, according to the init system   ###
if [[ "$init_system" == "systemd" ]]; then
dependencies=("mpd" "wildmidi" "ncmpcpp")
# Function to check if a package is installed
		check_dependency() {
		    dpkg -s "$1" >/dev/null 2>&1
		}

		# Collect missing packages
		missing_packages=()
		for dep in "${dependencies[@]}"; do
		    if ! check_dependency "$dep"; then
		        missing_packages+=("$dep")
		        echo "$dep is not installed."
		    fi
		done

		# If there are missing packages, ask for confirmation to install
		if [ ${#missing_packages[@]} -gt 0 ]; then
		 echo -e ""
		 echo -e "\033[34m================================================\033[31m"
		 echo -e "Installing missing packages,if any..." 
      abc="y"
		    if [[ "$abc" == "y" || "$abc" == "Y" ]]; then
		    echo -e "\033[0m"
				sudo apt-get install -y "${missing_packages[@]}"
		    else
		        echo "Installation aborted."
		    fi
		else
		    echo -e "\033[44m\033[30mAll dependencies are installed.\033[0m"
		fi


else
 # Handle Arch-based systems, install necessary dependencies
        sudo pacman -Syu --noconfirm
        sudo pacman -S --needed mpd ncmpcpp wildmidi --noconfirm
  echo -e "System dependencies \033[31mmpd, ncmpcpp \033[0mand \033[31mwildmidi \033[0minstalled."
fi

###   Move configuration files to their respective directories   ####
sudo mv /home/batan/mpd/mpd /home/batan/.config/
sudo mv /home/batan/mpd/ncmpcpp /home/batan/.config/
sudo mv /home/batan/mpd/timidity.cfg /etc/timidity/timidity.cfg 
sudo mv /home/batan/mpd /home/batan/.mpd
