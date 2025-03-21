#!/bin/bash

# Ensure ansible package is installed on specific machine

# check_os() {
# if [ -f /etc/os-release ]; then
# source /etc/os-release && echo "$ID"
# fi
# }
# check_os_version() {
# if [ -f /etc/os-release ]; then
# source /etc/os-release && echo "$VERSION_ID"
# fi
# }

# os_name=$(check_os)
# os_version=$(check_os_version)

# case "$os_name" in
# ubuntu)
# sudo apt-get update &&
# sudo apt-get install -yqq software-properties-common -y &&
# sudo add-apt-repository --yes --update ppa:ansible/ansible &&
# sudo apt-get install -yqq ansible ansible-lint
# ;;
# debian)
# case "$os_version" in
# 12) UBUNTU_CODENAME=jammy ;;
# 11) UBUNTU_CODENAME=focal ;;
# 10) UBUNTU_CODENAME=bionic ;;
# esac

# sudo apt-get update && sudo apt-get install -yqq wget gnupg2 apt-transport-https

# wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" |
# sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg &&
# echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" |
# sudo tee /etc/apt/sources.list.d/ansible.list &&
# sudo apt-get update &&
# sudo apt-get install ansible ansible-lint -yqq
# ;;
# centos)
# sudo yum update -y && sudo yum install -y nano python3 python3-pip
# python3 -m pip install --upgrade pip
# python3 -m pip install --user ansible ansible-lint
# ;;
# arch)
# sudo pacman -Syu --noconfirm ansible
# ;;
# esac

if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get update &&
		sudo apt-get install -y python3 python3-pip pipx
elif command -v dnf >/dev/null 2>&1; then
	sudo dnf update -y
	sudo dnf install -y python3 python3-pip pipx
elif command -v pacman >/dev/null 2>&1; then
	sudo pacman -Syu --noconfirm
	sudo pacman -S --noconfirm python python-pip python-pipx
fi

# Temporarily add user bin PATH
export PATH="$HOME/.local/bin:$PATH"

# Install minimal ansible package
pipx install --include-deps ansible
pipx inject ansible argcomplete
pipx install ansible-lint
