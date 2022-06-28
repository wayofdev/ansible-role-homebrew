#!/bin/bash
#
# Uninstalls Homebrew using the official uninstallation script.

### Download and run the uninstallation script.
# curl -sLO https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh
# chmod +x ./uninstall.sh
# sudo ./uninstall.sh --force
sh ./contrib/homebrew-install/uninstall.sh --force

### Clean up Homebrew directories.
sudo rm -rf /usr/local/Homebrew
sudo rm -rf /usr/local/Caskroom
sudo rm -rf /usr/local/bin/brew

### Additional directories
# sudo rm -rf /usr/local/Frameworks
# sudo rm -rf /usr/local/bin
# sudo rm -rf /usr/local/etc
# sudo rm -rf /usr/local/include
# sudo rm -rf /usr/local/lib
# sudo rm -rf /usr/local/opt
# sudo rm -rf /usr/local/sbin
# sudo rm -rf /usr/local/share
# sudo rm -rf /usr/local/var

### Github runner specific directories
# sudo rm -rf /usr/local/sessionmanagerplugin
# sudo rm -rf /usr/local/microsoft
# sudo rm -rf /usr/local/miniconda
# sudo rm -rf /usr/local/aws-cli
