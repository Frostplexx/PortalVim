#!/bin/bash

# === User Variables === 
VIM_CONFIG_URL="https://github.com/Frostplexx/vim-config.git"

# Define variables
INSTALL_DIR_LINUX="nvim_linux_squashfs"
INSTALL_DIR_MACOS="nvim_macos_squashfs"

BIN_DIR_LINUX="$INSTALL_DIR_LINUX/usr/bin"
BIN_DIR_MACOS="$INSTALL_DIR_MACOS/usr/bin"

CONFIG_DIR_LINUX="$INSTALL_DIR_LINUX/etc/nvim"
CONFIG_DIR_MACOS="$INSTALL_DIR_MACOS/etc/nvim"

ARCHIVE_NAME_LINUX="nvim-linux.squashfs"
ARCHIVE_NAME_MACOS="nvim-macos.squashfs"

# Prepare the directory structure for Linux
mkdir -p "$BIN_DIR_LINUX" "$CONFIG_DIR_LINUX"
# Prepare the directory structure for macOS
mkdir -p "$BIN_DIR_MACOS" "$CONFIG_DIR_MACOS"

# Step 3: Download and extract the Neovim binaries
# For Linux
curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz | tar -xz -C "$BIN_DIR_LINUX" --strip-components=1
# For macOS
curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz | tar -xz -C "$BIN_DIR_MACOS" --strip-components=1

# Step 4: Create or copy your Neovim configuration
# For Linux
git clone "$VIM_CONFIG_URL" "$CONFIG_DIR_LINUX"
# For macOS
git clone "$VIM_CONFIG_URL" "$CONFIG_DIR_MACOS"

# Step 5: Create the SquashFS archives
rm -f "$ARCHIVE_NAME_LINUX" "$ARCHIVE_NAME_MACOS"
# For Linux
mksquashfs "$INSTALL_DIR_LINUX" "$ARCHIVE_NAME_LINUX" -b 1024k -comp xz -Xbcj x86
# For macOS (Note: macOS does not support -Xbcj x86, so we omit this option)
mksquashfs "$INSTALL_DIR_MACOS" "$ARCHIVE_NAME_MACOS" -b 1024k -comp xz

# Cleanup
rm -rf "$INSTALL_DIR_LINUX"
rm -rf "$INSTALL_DIR_MACOS"

echo "SquashFS archives have been created."

