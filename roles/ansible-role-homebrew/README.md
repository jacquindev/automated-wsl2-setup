Ansible-Role-Homebrew
=========

Install Homebrew on Linux (Debian/Redhat) and Homebrew configuration

Requirements
------------

None.

Role Variables
--------------

```yaml
homebrew_init_shell: true
homebrew_profile: bash      # bash | zsh | fish
homebrew_autocompletion: true

homebrew_taps: []
homebrew_packages: []
homebrew_blacklist: []

homebrew_use_brewfile: false
homebrew_brewfile_dir: ""

homebrew_update: false
```

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Install Homebrew and add Homebrew integration to fish shell profile file.
  hosts: localhost

  vars:
    homebrew_init_shell: true
    homebrew_autocompletion: true
    homebrew_profile: fish

    homebrew_taps:
      - hashicorp/tap

    homebrew_packages:
      - hashicorp/tap/terraform
      - hashicorp/tap/vagrant

  roles:
    - role: ansible-role-homebrew
      tags: ["homebrew"]
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
