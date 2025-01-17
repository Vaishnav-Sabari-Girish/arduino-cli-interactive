# Chapter 1  (Installation of Tools)

## Installation of `arduino-cli-interactive` or `aci`

For now there are 2 ways to install the `aci` tool. 

1. Download from source 

```bash
git clone https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git
cd bash_shell_script
chmod +x main.sh 
./main.sh 
```

2. Using Homebrew

To download `aci` using Homebrew , you need to first have homebrew installed. 
To install homebrew , copy and paste this script in your terminal

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After Homebrew is installed , copy and paste the following commands in the terminal 

```bash
brew update 
brew tap vaishnav-sabari-girish/arduino-cli-interactive
brew install aci 
```

## Pre-requisites 

For the `aci` tool to work as intended , there are 2 prerequisite tools required. 

### `arduino-cli`

Arduino-cli can be installed using 2 ways

1. Using Homebrew 

```bash
brew update
brew install arduino-cli
```

2. Using their installation script 

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

For other installation methods , check out their website [here](https://arduino.github.io/arduino-cli/1.1/installation/)

### `gum`

This tool helps create awesome looking Terminal User Interfaces (TUI's). 
You can download `gum` in multiple ways. 

1. Using Homebrew 

```bash
brew update
brew install gum
```

2. Using Package Managers 

```bash
#Arch Linux (btw)
pacman -S gum

# Nix
nix-env -iA nixpkgs.gum 

# Flox 
flox install gum 
```
<br><br>

### `timer`
This is an interactive alternative to the default `sleep` command. It provides aesthetic progress bars. 

You can install it using 
1. Homebrew

```bash
 brew install caarlos0/tap/timer
```

For other ways to install `timer` checkout it's [Github Repo](https://github.com/caarlos0/timer)

<br><br>

You can also install a few alternative text editors if you do not want to use the default `nano` editor 
of linux. 

Some options are :

1. <a id="micro">Micro</a>


```bash
sudo apt-get install micro
```

2. <a id="vim">Vim</a>

```bash
sudo apt-get install vim 
```

3. <a id="neovim">NeoVim</a>

```bash
sudo apt install nvim
```

4. <a id="gedit">Gedit</a>

```bash
sudo apt install gedit
```

5. <a id="vscode">Visual Studio Code</a>

```bash

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
```

```bash

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
```

6. <a id="vscodium">VSCodium</a>

```bash
#Using snap 
snap install codium --classic

#Using Nix 
nix-env -iA nixpkgs.vscodium

#Arch Linux 
yay -S vscodium-bin
```

```bash 
#For Debian/Ubuntu distros 

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install codium
```

7. <a id="hx">Helix</a>

```bash
#For Debian/Ubuntu distos 
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix

#For Fedora/RHEl 
sudo dnf install helix

#Homebrew 
brew install helix 

#AppImage (First download the .AppImage file from the official helix repo)
chmod +x helix-*.AppImage # change permission for executable mode
./helix-*.AppImage # run helix
```

## Post Installation 

After the installation of `aci` there is one small step you have to do. 

Type the following in the terminal 

```bash
arduino-cli board listall
arduino-cli core install arduino:avr
```

This step will make sure you have the cores of the basic Arduino Boards like Uno , Nano etc. 
