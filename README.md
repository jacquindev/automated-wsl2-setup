# Automated Setup WSL2 Machine

This repository contains Ansible playbook to automatically configure WSL2 instance.

> [!WARNING]
> This is a **WORK IN PROGRESS** project. Please use with caution!!

<br>

## Requirements

- [Git](https://git-scm.com/downloads) version **v2.39.0 or greater** to be installed on the machine.

	```bash
	# On Ubuntu/Debian
	sudo apt-get install -y git

	# On CentOS
	sudo dnf install -y git
	```

## Features

> [!NOTE]
> This playbook is fully configurable. <br>
> You can skip or reconfigure any task for your needs. See [Usage](#Usage) for more information.

## Supports

The following WSL2 images are currently supported (**tested**):

- **Ubuntu 22.04** (Jammy)
- **Ubuntu 24.04** (Noble)
- **Debian 12** (Bookworm)
- **CentOS 9 Stream**

Other Linux images for WSL2 have not been tested yet.
Futher updates will available soon...

## Installation

1. Clone this repository using `git`:

	```bash
	git clone https://github.com/jacquindev/automated-wsl2-setup.git /your/location
	```

2. `cd` into `/your/location` of where you cloned this repo.

3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

	- You can do this *manually* **OR**
	- (Recommended) Run the ***[init.sh](./init.sh)*** to setup [Ansible](https://docs.ansible.com/ansible/latest/index.html) on your machine.

4. Install `requirements` for this playbook:

	```bash
	ansible-galaxy install -r requirements.yml
	```

5. Run the [main.yml](./main.yml) file to start the setup process:

	```bash
	ansible-playbook --ask-become-pass main.yml
	```

## Usage

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using ansible-playbook's --tags flag.

For example:

```bash
ansible-playbook --ask-become-pass main.yml -K --tags "dotfiles,homebrew"
```

### Overriding Defaults

> [!IMPORTANT]
> Please override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and set different values for your preferences.

#### Example of a `config.yml` file

Supposed that you are setting on **CentOS WSL2** machine:

```yaml
# Packages to install via dnf:
installed_packages:
  - epel-release
  - dnf-plugins-core
  - redhat-lsb-core
  - wget
  - unzip

# wsl.conf settings
wsl_boot_command: service docker start
wsl_hostname: centos-wsl

# Required if you want to setup git to communicate with WSL2
git_username: John Doe
git_email: johndoe@example.com

# To NOT configure your machine with Homebrew (do not install Homebrew and its packages)
configure_homebrew: false

# To exclude the installations by homebrew using Brewfile:
homebrew_use_brewfile: false
homebrew_taps:
  - hashicorp/tap
homebrew_packages:
  - eza
  - gh
  - git-extras
  - hashicorp/tap/terraform
  - hashicorp/tap/vagrant

# To NOT configure your machine with dotfiles:
configure_dotfiles: false

# Specific dotfiles values:
# For more information, please visit:
# - https://github.com/geerlingguy/ansible-role-dotfiles
dotfiles_repo: https://github.com/<your_git_name>/<your_git_repo_name>.git
dotfiles_repo_version: master
```

In some cases, you might not want to use *[Docker Desktop](https://www.docker.com/products/docker-desktop/)* on your Windows machine, you should install `Docker` on your WSL2 instance.

This can easily be done by setting **`configure_docker`** to **`true`** in your `config.yml` file.

## Credits

This project was heavily inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

Other references/sources:
- [geerlingguy.mac](https://github.com/geerlingguy/ansible-collection-mac)
- [geerlingguy.dotfiles](https://github.com/geerlingguy/ansible-role-dotfiles)
- [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
- [fazlearefin/ubuntu-dev-machine-setup](https://github.com/fazlearefin/ubuntu-dev-machine-setup)

## License

Licensed under the [MIT License](https://github.com/jacquindev/automated-wsl2-setup/blob/master/LICENSE).

## Author

This project was created in 2025 by [Jacquin Moon](https://github.com/jacquindev).
