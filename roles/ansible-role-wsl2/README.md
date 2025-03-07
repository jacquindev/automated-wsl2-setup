Ansible-Role-WSL2
=========

Basic setup for WSL2 machine.

Requirements
------------

None.

Role Variables
--------------

```yaml
installed_packages: []    # List of packages to install
disabled_packages: []     # List of packages to disable
```

The below settings will be defined in `/etc/wsl.conf` file. Feel free to modify:

```yaml
wsl_username: "{{ ansible_user_id }}"              
wsl_boot_systemd: true
wsl_boot_command: ""

wsl_hostname: ""
wsl_network_generate_hosts: true
wsl_network_generate_resolve_config: true

wsl_interop_enabled: true
wsl_interop_append_windows_path: true

wsl_automount_enabled: true
wsl_automount_fstab: true
wsl_automount_root: /mnt/
wsl_automount_options: "metadata,umask=77,fmask=11"
```

By default, this role will create XDG directories if not found, and add XDG variables into `.bashrc` file in your `$HOME` directory.
To NOT let `Ansible` configure your `.bashrc` with XDG variables, set:

```yaml
xdg_init_shell: false
```

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Setup WSL2 machine (Ubuntu)
  hosts: localhost

  vars_prompt:
    - name: git_username
      prompt: What is your git username?
      private: false
    
    - name: git_email
      prompt: What is your git email?
      private: false
  
  roles:
    - role: ansible-role-wsl2
      tags: ["wsl2", "wsl"]
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by [Jacquin Moon](https://github.com/jacquindev)
