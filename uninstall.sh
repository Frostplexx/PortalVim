#!/bin/bash

# Check if current device is mac or x86-linux
if [[ "$OSTYPE" == "darwin"* ]]; then
	IS_MAC=true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	IS_MAC=false
else
	echo "Unsupported OS, cannot continue (See ReadMe.md)"
	exit 1
fi

if [ "$IS_MAC" = true ]; then
    echo "Not yet supported"
else
    echo "Removing nvim from PATH"
    sudo rm ~/.config/nvim
    sudo rm -r /mnt/nvim
    sudo rm ~/nvim-linux.squashfs
    echo "Uninstall complete"
fi
