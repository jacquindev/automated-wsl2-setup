Ansible-Role-VSCode
=========

A simple role to install/uninstall VSCode extensions for a WSL instance.

Requirements
------------

**[Install VS Code and the WSL extension](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode#install-vs-code-and-the-wsl-extension)** on your Windows machine.

Role Variables
--------------

To install VS Code extensions:

```yaml
vscode_extensions_install: []
```

To uninstall VS Code extensions:

```yaml
vscode_extensions_uninstall: []
```

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Install VS Code extensions for WSL Ubuntu machine
  hosts: localhost

  vars:
    vscode_extensions_install:
      - redhat.ansible
      - foxundermoon.shell-format

    vscode_extensions_uninstall:
      - ms-azuretools.vscode-azureterraform
  
  roles:
    - role: ansible-role-vscode
      tags: ["vscode"]

```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by [Jacquin Moon](https://github.com/jacquindev)
