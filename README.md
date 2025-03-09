<div align="center">
  <h1>Automated Setup WSL2 Machine</h1>
  
  <br>
  
  <p align="center">
    <a href="https://skillicons.dev">
      <img src="https://skillicons.dev/icons?i=ansible,ubuntu,debian,redhat,docker,jenkins,git&theme=dark" />
    </a>
  </p>
</div>

<br>

This repository contains Ansible playbook to automatically configure WSL2 instance.


> [!WARNING]
> This is a **WORK IN PROGRESS** project. Please use with caution!! <br>
> <br>
> **PLEASE DO NOT RUN WITH ROOT PRIVILEGE**

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

- Configure WSL2 instance in `/etc/wsl.conf`.
- Install [Homebrew](https://brew.sh/) and Homebrew packages.
- Install [VS Code](https://code.visualstudio.com/) extensions. (if you have VS Code on your Windows machine)
- Configure [Docker Engine](https://docs.docker.com/engine/). (if not using [Docker Desktop](https://www.docker.com/products/docker-desktop/))
- Add your `dotfiles` repository and create symlinks.

## Supported Platforms

The following WSL2 images are currently supported (**tested**):

- **Ubuntu 22.04** (Jammy)
- **Ubuntu 24.04** (Noble)
- **Debian 12** (Bookworm)
- **CentOS 9 Stream**

Other Linux images for WSL2 have not been tested yet.

Any futher updates and improvements will be available soon.

## Installation

1. Clone this repository using `git`:

	```bash
	git clone https://github.com/jacquindev/automated-wsl2-setup.git /your/location
	```

2. `cd` into `/your/location` of where you cloned this repo.

3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

	- You can do this *manually* **OR**
	- (Recommended) Run the ***[init.sh](./init.sh)*** to setup [Ansible](https://docs.ansible.com/ansible/latest/index.html) on your machine.

4. Ensure [required Ansible roles and collections](./requirements.yml) of this playbook by using `ansible-galaxy` command:

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

#### Examples of a `config.yml` file

Supposed that you are setting on **CentOS WSL2** machine:

```yaml
# Packages to install via dnf:
dnf_installed_packages:
  - epel-release
  - dnf-plugins-core
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

This playbook has *`configure_vfox`* options, which allows you to quickly install apps for your DEVELOPMENT ENVIRONMENT. Simple usage can be defined in your `config.yml` as below:

```yaml
configure_vfox: true

# REQUIRED*: change this into your shell you are USING
# available options are: bash / zsh / fish
vfox_shell: bash

vfox_plugins:
  - name: nodejs
    versions:
      - 23.9.0    # latest available
      - 22.14.0   # LTS version
    global: 23.9.0

  - name: java
    versions:
      - 21.0.2-graalce
      - 17.0.14+7-amzn
    global: 21.0.2-graalce

  - name: golang
    versions:
      - 1.24.1
    global: 1.24.1
```

To install / uninstall [Visual Studio Code](https://code.visualstudio.com/) extensions for your WSL, please setup the following settings:

Please note that this supposed you already installed [VS Code](https://code.visualstudio.com/) on your Windows local machine and have [Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension installed.

Ensure that in your `[interop]` section of `wsl.conf` file, `enabled=true` and `appendWindowsPath=true`.

For more information, please check out this link -> **[ansible-role-vscode](./roles/ansible-role-vscode/README.md)**.

```yaml
configure_vscode: true

vscode_extensions_install:
  - redhat.ansible
  - redhat.vscode-yaml
  - tamasfe.even-better-toml

vscode_extensions_uninstall:
  - ms-azuretools.vscode-docker
```

To install and setup [Jenkins]() on your WSL instance, simply configure those settings:

```yaml
configure_jenkins: true

# Edit the list of jenkins plugins you would like to install:
jenkins_plugins:
  - ansicolor
  - blueocean
  - docker-workflow

jenkins_restart_method: safe-restart 	# service | safe-restart
```

For more information, please see [geerlingguy.jenkins](https://github.com/geerlingguy/ansible-role-jenkins)

In some cases, you might not want to use *[Docker Desktop](https://www.docker.com/products/docker-desktop/)* on your Windows machine, you should install `Docker` on your WSL2 instance.

This can easily be done by setting **`configure_docker`** to **`true`** in your `config.yml` file.

## Credits

This project was heavily inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

Other references/sources:

- [geerlingguy.mac](https://github.com/geerlingguy/ansible-collection-mac)
- [geerlingguy.dotfiles](https://github.com/geerlingguy/ansible-role-dotfiles)
- [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
- [geerlingguy.jenkins](https://github.com/geerlingguy/ansible-role-jenkins)
- [fazlearefin/ubuntu-dev-machine-setup](https://github.com/fazlearefin/ubuntu-dev-machine-setup)

## License

Licensed under the [MIT License](https://github.com/jacquindev/automated-wsl2-setup/blob/master/LICENSE).

## Author

This project was created in 2025 by [Jacquin Moon](https://github.com/jacquindev).
