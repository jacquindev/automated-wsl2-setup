# Automated Setup WSL2 Machine

This repository contains Ansible playbook to automatically configure WSL2 instance.

> [!WARNING]
> This is a **WORK IN PROGRESS** project. Please use with caution!! <br>

<hr>

[![infrastructures](https://skillicons.dev/icons?i=ansible,ubuntu,debian,redhat,docker,jenkins,git)](https://skillicons.dev)

## Requirements

**[Git](https://git-scm.com/downloads)** version **v2.39.0 or greater** to be installed on the machine.

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

### 1. Clone this repository using `git`

```bash
git clone https://github.com/jacquindev/automated-wsl2-setup.git /your/location
```

### 2. `cd` into `/your/location` of where you cloned this repo

### 3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

- You can do this *manually* **OR**
- (Recommended) Run the ***[init.sh](./init.sh)*** to setup [Ansible](https://docs.ansible.com/ansible/latest/index.html) on your machine.

### 4. Ensure [required Ansible roles and collections](./requirements.yml) of this playbook by using `ansible-galaxy` command:

```bash
ansible-galaxy install -r requirements.yml
```

### 5. Run the [main.yml](./main.yml) file to start the setup process:

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
> Please override any of the defaults configured in [`default.config.yml`](./vars/default.config.yml) by creating a `config.yml` file and set different values for your preferences.

👉👉👉 **EXAMPLES OF A `config.yml` FILE:**

- Supposed that you are running this playbook on **CentOS** WSL2 machine:

  ```yaml
  dnf_installed_packages:
    - epel-release
    - dnf-plugins-core
    - wget
    - unzip
    - zsh
  ```

- On **Ubuntu/Debian** WSL2 machine:

  ```yaml
  apt_installed_packages:
    - apt-transport-https
    - wget
    - unzip
    - zsh
  ```

- For `wsl.conf` settings, more options can be found at **[ansible-role-wsl2](./roles/ansible-role-wsl2/README.md)**. These settings are based on official [Microsoft's Advanced settings configuration in WSL](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf).

  ```yaml
  wsl_hostname: centos-wsl
  wsl_boot_command: service docker start
  ```

- Configure [git](https://git-scm.com/) username and email:

  ```yaml
  git_username: John Doe
  git_email: johndoe@example.com
  ```

- [Homebrew]() related settings:

  ```yaml
  # To NOT install and setup Homebrew on your machine
  configure_homebrew: false

  # To NOT install default packages list in this repo by its Brewfile
  homebrew_use_brewfile: false

  # To install packages from Brewfile but at a different location, let's say the Brewfile is in ~/Brewfile
  homebrew_brewfile_dir: "{{ ansible_user_dir }}"

  # OR let Ansible do its jobs
  # Tap Homebrew repositories
  homebrew_taps:
    - hashicorp/tap

  # Install Homebrew packages
  homebrew_packages:
    - bat
    - eza
    - gh
    - git-extras
    - hashicorp/tap/terraform
    - hashicorp/tap/vagrant
  ```

- Quickly bootstrap your machine with your own dotfiles repository, for more information please visit: **[geerlingguy.dotfiles](https://github.com/geerlingguy/ansible-role-dotfiles)**

  ```yaml
  # Set this to `false` to NOT setup your machine with dotfiles
  configure_dotfiles: true

  # Where is your dotfiles repository located?
  dotfiles_repo: https://github.com/<your_git_username>/<your_dotfiles_repo_name>.git
  dotfiles_repo_version: master
  ```

- This playbook use **[vfox](https://vfox.dev/)** as a [development environments manager](./roles/ansible-role-vfox/README.md). To enable the capability of installing development tools, in your `config.yml` file:

  ```yaml
  configure_vfox: true

  # This is REQUIRED for correct `vfox` shell initialization in Ansible
  # Change this variable into with SHELL you are USING, 
  # available options are: bash | zsh | fish
  vfox_shell: bash

  # Do you want to let vfox use legacy version file?
  vfox_legacy_version: true

  # Define a list of plugins and their package versions
  vfox_plugins:
    - name: nodejs
      versions:
        - 23.9.0
        - 22.14.0
      global: 23.9.0
    
    - name: java
      versions:
        - 21.0.2-graalce
        - 17.0.14+7-amzn
      global: 21.0.2-graalce
  ```

- To let Ansible to install [Visual Studio Code](https://code.visualstudio.com/) extensions on your WSL2:

  ```yaml
  configure_vscode: true

  vscode_install_suggested_extensions: false

  vscode_extensions_install:
  - redhat.ansible
  - redhat.vscode-yaml
  - tamasfe.even-better-toml

  vscode_extensions_uninstall:
  - ms-azuretools.vscode-docker

  vscode_settings_force: true
  vscode_settings:
    workbench.panel.defaultLocation: "left"
  ```

- Please note that this supposed you already installed [Visual Studio Code](https://code.visualstudio.com/) on your Windows local machine, and have [Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) installed. Also, ensure that your WSL2 instance have VSCode on `PATH`. For instance, your `/etc/wsl.conf`'s `[interop]` section label should have settings: `enabled=true` and `appendWindowsPath`. These are usually enabled by default.

- For more information, have a look at **[ansible-role-vscode](./roles/ansible-role-vscode/README.md)**.

- On a DevOps machine, you would like to install and start [Jenkins](https://www.jenkins.io/) after fresh setup. This can be done by simply configure those settings:

  ```yaml
  configure_jenkins: true

  # Edit the list of jenkins plugins you would like to install:
  jenkins_plugins:
    - ansicolor
    - blueocean
    - docker-workflow

  jenkins_restart_method: safe-restart 	# service | safe-restart
  ```

- Any further [Jenkins](https://www.jenkins.io/)'s setup configurations, see **[geerlingguy.jenkins](https://github.com/geerlingguy/ansible-role-jenkins)**

- In some cases, you might not want to use [Docker Desktop](https://www.docker.com/products/docker-desktop/) on your Windows local machine. You can install [Docker](https://www.docker.com/) inside the WSL2 instance by setting `configure_docker` to `true` in your `config.yml` file. More specific settings for this behavior can be found at **[geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)**

  ```yaml
  configure_docker: true
  ```

- [Extra packages](./vars/packages.yml) can be overridden:

  ```yaml
  # Set this to `true` to install extra packages
  extra_packages: true

  npm_packages:
    - czg
    - npm-check-updates

  go_packages:
    - github.com/go-task/task/v3/cmd/task
    - github.com/melkeydev/go-blueprint

  composer_packages:
    - name: drush/drush
      version: '^8.1'

  pipx_packages:
    - poetry
    - poethepoet

  pip_packages:
    - mkdocs

  gem_packages:
    - name: bundler
      state: latest
  ```

## Homebrew Default Packages

<details>
<summary><i>Packages are listed in </i><b><a href="./Brewfile">Brewfile</a></b></summary>

```ruby
tap "homebrew/bundle"

# General
brew "bat"
brew "btop"
brew "dua-cli"
brew "eza"
brew "fd"
brew "fzf"
brew "jq"
brew "luarocks"
brew "neovim"
brew "rich-cli"
brew "ripgrep"
brew "shellcheck"
brew "starship"
brew "stow"
brew "tealdeer"
brew "thefuck"
brew "vfox"
brew "wrk"
brew "yazi"
brew "yq"
brew "zoxide"

# Git addons
brew "gh"
brew "git-delta"
brew "git-extras"
brew "git-flow"
brew "git-lfs"
brew "lazygit"

# Kubernetes applications
brew "helm"
brew "helmfile"
brew "k3d"
brew "kind"
brew "kustomize"
brew "minikube"

tap "derailed/k9s"
brew "derailed/k9s/k9s"

# Hashicorp packages
tap "hashicorp/tap"
brew "hashicorp/tap/terraform"
brew "hashicorp/tap/vagrant"
```

</details>

## Credits

This project was inspired by:

- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
- [fazlearefin/ubuntu-dev-machine-setup](https://github.com/fazlearefin/ubuntu-dev-machine-setup)

Other references / resources:

- [geerlingguy.mac](https://github.com/geerlingguy/ansible-collection-mac)
- [geerlingguy.dotfiles](https://github.com/geerlingguy/ansible-role-dotfiles)
- [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
- [geerlingguy.jenkins](https://github.com/geerlingguy/ansible-role-jenkins)


## License

Licensed under the [MIT License](https://github.com/jacquindev/automated-wsl2-setup/blob/master/LICENSE).

## Author

This project was created in 2025 by [Jacquin Moon](https://github.com/jacquindev).
