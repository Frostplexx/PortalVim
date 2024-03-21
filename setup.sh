#!/bin/bash
#
#
# === User Variables ===
PORTAL_VIM_REPO="https://github.com/Frostplexx/PortalVim"





LINUX_SQUASHFS=$PORTAL_VIM_REPO"/raw/main/nvim-linux.squashfs"
MACOS_SQUASHFS=$PORTAL_VIM_REPO"/raw/main/nvim-macos.squashfs"


# Check if current device is mac or x86-linux
if [[ "$OSTYPE" == "darwin"* ]]; then
	IS_MAC=true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	IS_MAC=false
else
	echo "Unsupported OS, cannot continue (See ReadMe.md)"
	exit 1
fi


echo "  _____           _        ___      ___           "
echo " |  __ \         | |      | \ \    / (_)          "
echo " | |__) |__  _ __| |_ __ _| |\ \  / / _ _ __ ___  "
echo " |  ___/ _ \|  __| __/ _  | | \ \/ / | |  _   _ \ "
echo " | |  | (_) | |  | || (_| | |  \  /  | | | | | | |"
echo " |_|   \___/|_|   \__\__,_|_|   \/   |_|_| |_| |_|"
                                                  
if [ "$IS_MAC" = true ]; then
    echo "Not yet supported"
else
    echo "Downloading Linux SquashFS"
    curl -L $LINUX_SQUASHFS -o nvim-linux.squashfs

    echo "Extracting Linux SquashFS into mounted directory"
    sudo mkdir -p /mnt/nvim
    sudo mount -o loop nvim-linux.squashfs /mnt/nvim

    echo "Temporarily adding nvim to PATH"

    export PATH=$PATH:/mnt/nvim/usr/bin

    # Set NVIM_APPNAME for nvim to point to mounter config
    export NVIM_APPNAME="/mnt/nvim/etc/nvim"

    alias v=nvim

fi
