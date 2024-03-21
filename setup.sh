#!/bin/bash
#
#
# === User Variables ===
PORTAL_VIM_REPO="https://github.com/Frostplexx/PortalVim"
# ======================

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
echo "A temporary, portable, and disposable neovim environment"
echo ""
echo ""
echo ""

read -p "Do you want to (i)nstall or (u)ninstall PortalVim?: " -n 1 -r
echo
if [[ $REPLY =~ ^[iI]$ ]]; then
    if [ "$IS_MAC" = true ]; then
        echo "Not yet supported"
    else
        echo "Downloading Linux SquashFS"
        curl -L $LINUX_SQUASHFS -o ~/nvim-linux.squashfs
    
        # check if unsquashfs is installed
        if ! [ -x "$(command -v unsquashfs)" ]; then
            echo "Error: unsquashfs is not installed." >&2
            echo "Please install squashfs-tools" >&2
            exit 1
        fi
    
        echo "Extracting Linux SquashFS into mounted directory"
        sudo mkdir -p /mnt/nvim
        sudo unsquashfs -d /mnt/nvim nvim-linux.squashfs
    
        echo "Temporarily adding nvim to PATH"
    
        sudo export PATH=$PATH:/mnt/nvim/usr/bin/bin
    
        ln -s /mnt/nvim/etc/nvim ~/.config/nvim
    
        echo "Setting up aliases for nvim"
        alias v=nvim
        alias vim=nvim

        echo "Installation complete!"
    
    fi
elif [[ $REPLY =~ ^[uU]$ ]]; then
    bash <(curl -s https://raw.githubusercontent.com/Frostplexx/PortalVim/main/uninstall.sh)
elif [[ $REPLY =~ ^[qQ]$ ]]; then
    exit
fi

                                                  
