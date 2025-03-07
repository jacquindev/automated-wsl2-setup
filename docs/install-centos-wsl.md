# How To Install CentOS Distro For WSL

A brief guide to setup CentOS distribution on WSL.

## Install a CentOS version in WSL2

- Follow this link: [mishamosher's CentOS-WSL](https://github.com/mishamosher/CentOS-WSL) and grab a CentOS version.
- Download ZIP file and extract it to your desired location.
- Navigate to the extracted folder and run the `.exe` file.

Those steps above can be done in a [PowerShell](https://github.com/PowerShell/PowerShell) console. For example, to setup a [CentOS 9 Stream](https://www.centos.org/stream9/) distro:

```pwsh
Set-Location "H:\test"

& curl.exe -sSfL "https://github.com/mishamosher/CentOS-WSL/releases/download/9-stream-20230626/CentOS9-stream.zip" -o CentOS9-Stream.zip

Expand-Archive .\CentOS9-Stream.zip
Remove-Item .\CentOS9-Stream.zip -Force -Recurse -ErrorAction SilentlyContinue

. .\CentOS9-stream.exe
```

Now run ***`wsl -l -v`*** in your `PowerShell` or `Command Prompt` terminal, you should see `CentOS9-stream` on the list.

To start `CentOS9-stream`, simply run ***`wsl -d CentOS9-stream`***.

## Setup CentOS's default user

Inside the CentOS instance, create a default user:

```bash
username=johndoe
adduser -G wheel $username
passwd $username

echo -e "[user]\ndefault=$username" >> /etc/wsl.conf
```

You must now quit out of the instance, and restart it:

```pwsh
wsl --terminate CentOS9-stream
wsl -d CentOS9-stream
```

## References

- [Import and Linux distribution to use with WSL](https://learn.microsoft.com/en-us/windows/wsl/use-custom-distro)
- [How to Install CentOS 9 Stream in WSL in Windows](https://bonguides.com/how-to-install-centos-9-stream-in-wsl-in-windows/)
