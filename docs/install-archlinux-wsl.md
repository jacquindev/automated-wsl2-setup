# How to Set Up ArchWSL

A brief guide to setup ArchLinux distribution on WSL.

## Install ArchLinux in WSL2

- Follow this link: [yuk7's ArchWSL](https://github.com/yuk7/ArchWSL) and grab a ArchWSL version.
- Download ZIP file and extract it to your desired location.
- Navigate to the extracted folder and run the `.exe` file.

Those steps above can be done in a [PowerShell](https://github.com/PowerShell/PowerShell) console:

```pwsh
Set-Location "H:\test"

& curl.exe -sSfL "https://github.com/yuk7/ArchWSL/releases/download/25.3.2.0/Arch.zip" -o Arch.zip

Expand-Archive .\Arch.zip
Remove-Item .\Arch.zip -Force -Recurse -ErrorAction SilentlyContinue

. .\Arch.exe
```

Other methods to setup ArchWSL is in this **[LINK](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)**

Now run ***`wsl -l -v`*** in your `PowerShell` or `Command Prompt` terminal, you should see `Arch` on the list.

To start `ArchWSL`, simply run ***`wsl -d Arch`***.

## Setup ArchWSL's default user

Inside the `Arch` instance, create a default user:

```bash
# Setup root password
passwd

# Setup sudoers file
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel

# Add default username and password
username=johndoe
useradd -m -G wheel -s /bin/bash $username
passwd $username

exit
```

Now run:

```pwsh
wsl.exe --terminate Arch

.\Arch.exe config --default-user johndoe

wsl.exe -d Arch
```

Initialize keyring for use with `pacman`

```bash
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su
```

## References

- [Import and Linux distribution to use with WSL](https://learn.microsoft.com/en-us/windows/wsl/use-custom-distro)
- [How to Set Up ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)
