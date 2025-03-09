Ansible-Role-Vfox
=========

Install vfox via Homebrew if not found & its plugins.

Requirements
------------

- Homebrew installed

Role Variables
--------------

```yaml
# REQUIRED: Change this variable to which shell you are using
vfox_shell: bash  # bash | zsh | fish

# Whether or not to  let vfox can read legacy version files
vfox_legacy_version: true

# List of plugins to install here
vfox_plugins: []
```

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- name: Install vfox plugins
  hosts: localhost

  vars:
    vfox_shell: fish
    
    vfox_plugins:
      - name: java
        versions:
          - 21.0.2-graalce
          - 17.0.14+7-amzn
        global: 21.0.2-graalce
      - name: nodejs
        versions:
          - 23.9.0
          - 22.14.0
        global: 23.9.0

  roles:
    - role: ansible-role-vfox
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by [Jacquin Moon](https://github.com/jacquindev)
