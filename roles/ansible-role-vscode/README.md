Ansible-Role-VSCode
=========

A simple role to install/uninstall VSCode extensions for a WSL instance.

Requirements
------------

**[Install VS Code and the WSL extension](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode#install-vs-code-and-the-wsl-extension)** on your Windows machine.

Role Variables
--------------

Default suggested VS Code extensions:

```yaml
# Set this settings to `false` to not install 'suggested' extensions below:
vscode_install_suggested_extensions: true
vscode_suggested_extensions:
  - alefragnani.project-manager
  - bierner.github-markdown-preview
  - donjayamanne.githistory
  - editorconfig.editorconfig
  - formulahendry.code-runner
  - foxundermoon.shell-format
  - github.vscode-github-actions
  - github.vscode-pull-request-github
  - timonwong.shellcheck
  - redhat.ansible
  - redhat.vscode-xml
  - redhat.vscode-yaml
```

To install VS Code extensions:

```yaml
vscode_extensions_install: []
```

To uninstall VS Code extensions:

```yaml
vscode_extensions_uninstall: []
```

Whether or not to force rewrite VSCode settings

```yaml
vscode_settings_force: false
```

Default VS Code settings

```yaml
vscode_settings:
  # Panel position:
  workbench.panel.defaultLocation: "bottom" # bottom | left | right | top
  # DEFAULT settings for VSCode Project Manager extensions
  # - https://github.com/alefragnani/vscode-project-manager
  # - https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager
  projectManager.groupList: true
  projectManager.removeCurrentProjectFromList: false
  projectManager.checkInvalidPathsBeforeListing: true
  projectManager.supportSymlinksOnBaseFolders: false
  projectManager.showParentFolderInfoOnDuplicates: false
  projectManager.filterOnFullPath: false
  projectManager.projectsLocation: ""
  projectManager.git.baseFolders: []
  projectManager.git.ignoredFolders: []
  projectManager.git.maxDepthRecursion: 4
  projectManager.ignoreProjectsWithinProjects: false
  projectManager.cacheProjectsBetweenSessions: true
  projectManager.showProjectNameInStatusBar: true
  projectManager.openInNewWindowWhenClickingInStatusBar: false
  projectManager.openInCurrentWindowIfEmpty: "always" # always | onlyUsingCommandPalette | onlyUsingSideBar | never
  projectManager.tags: ["Personal", "Work"]
```

Define a list of projects which will be managed by [VSCode Project Manager](https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager) extension

```yaml
vscode_projects: []
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
    vscode_install_suggested_extensions: true
    vscode_extensions_install:
      - redhat.ansible
      - foxundermoon.shell-format
      - esbenp.prettier-vscode

    vscode_extensions_uninstall:
      - ms-azuretools.vscode-azureterraform

    vscode_settings_force: true
    vscode_settings:
      editor.defaultFormatter: "esbenp.prettier-vscode"
      "[javascript]": 
        editor.defaultFormatter: "esbenp.prettier-vscode"
        editor.formatOnSave: true
    
    vscode_projects:
      - name: "My dotfiles"
        rootPath: "~/.dotfiles"
        tags: ["Personal"]
        enabled: true
  
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
