<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Documentation Links](#documentation-links)
- [Arduino Interactive CLI](#arduino-interactive-cli)
  - [Before Installation.](#before-installation)
  - [Testing the Tool (before install)](#testing-the-tool-before-install)
  - [Installation](#installation)
      - [Via Homebrew](#via-homebrew)
      - [From source](#from-source)
    - [Pre-requisites](#pre-requisites)
      - [1. `arduino-cli`](#1-arduino-cli)
        - [Homebrew](#homebrew)
        - [macOS/Linux](#macoslinux)
        - [For windows users](#for-windows-users)
        - [Installing `arduino-cli` using the installation script](#installing-arduino-cli-using-the-installation-script)
        - [Using the Pre-built Binaries](#using-the-pre-built-binaries)
      - [2. `gum`](#2-gum)
      - [3. `timer`](#3-timer)
  - [Usage](#usage)
    - [To update the app](#to-update-the-app)
      - [Using Homebrew](#using-homebrew)
      - [By Cloning the latest repository](#by-cloning-the-latest-repository)
    - [To Uninstall](#to-uninstall)
    - [Features provided by `aci`](#features-provided-by-aci)
      - [Legends](#legends)
- [Stargazers over Time](#stargazers-over-time)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

![Banner](banner.png)
<br><br>

[![Release Badge](https://badgen.net/badge/Release/v1.1.0/green?icon=github)](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/tag/v1.1.0)

![License](license-apache-2.0.svg)

![Bash Script](made-with-bash.svg)



# Documentation Links 

1. [Github Pages](https://vaishnav-sabari-girish.github.io/arduino-cli-interactive/)
2. [Codeberg Pages](https://vaishnav-sabari-girish.codeberg.page/pages/intro.html)

My tool is also available on TerminalTrove.com if you’d like to check it out there.

[![TerminalTrove](https://img.shields.io/badge/Available%20on-TerminalTrove-brightgreen?style=for-the-badge)](https://terminaltrove.com/arduino-cli-interactive/)

# Arduino Interactive CLI

This tool is made specifically for those who want to transition from the Arduino IDE to the CLI , but are still scared or intimidated by the command line. 

## Before Installation. 

Before installing the tool, make sure you create a GitHub PAT (Personal Access Token), so that you can be notified when
the tool gets a new version. 

You can create a PAT token [here](https://github.com/settings/tokens). Make sure you choose Tokens (Classic), and give repo
permissions for your token. 

Once you have your PAT, copy it and save it as an Environment variables in your ~/.bashrc or ~/.zshrc file as follows :

```bash
export ACI_GITHUB_TOKEN="<your PAT>"
```

Then source your file and then install `aci`

## Testing the Tool (before install)

If you want to know how the tool works without installing it, copy and paste the below command :

```bash
curl -sSL https://raw.githubusercontent.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/refs/heads/main/bash_shell_script/main.sh | bash
```

## Installation

#### Via Homebrew 

```bash
brew install vaishnav-sabari-girish/arduino-cli-interactive/aci
```

#### From source 

```bash

# Cloning from GitHub 
git clone https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

# Cloning from CodeBerg.org 
git clone https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

# Cloning from Radicle 
## Using git 
git clone https://seed.radicle.garden/z2xtEKkr65SpfQZUQWgqVKSVkfbfw.git arduino-cli-interactive 
## Using Radicle CLI 
rad clone rad:z2xtEKkr65SpfQZUQWgqVKSVkfbfw 


cd bash_shell_script
chmod +x main.sh 
./main.sh 
```

Then open your `~/.bashrc` or `~/.zshrc` file and add this alias 
```bash
alias aci="<path to the cloned repository>"
```

Then in the terminal type 
```bash
source ~/.bashrc # For bash users 
source ~/.zshrc  # For zsh users
```

### Pre-requisites

If not installed, the script will do it on it's own. But just in case something doesn't install properly do the below. 

#### 1. `arduino-cli` 

There are many ways to install arduino-cli. I recommend Homebrew , because all the other prerequisite tools are also available on homebrew. 

##### Homebrew 

In case you do not have Homebrew installed in your system 

##### macOS/Linux

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

##### For windows users

Use Windows Subsystem for Linux (WSL) and follow the instructions for Linux.

To learn to use WSL , the best video is by [NetworkChuck](https://youtu.be/vxTW22y8zV8?si=mZ5w9KmT0A4_d7Zr)

<br>

After installing Homebrew , go to your terminal and just type this 

```bash
brew update
brew install arduino-cli
```
##### Installing `arduino-cli` using the installation script

If you do not want to use homebrew , you can copy and paste this installation script 

`curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh`

**NOTE** : This script is only for Linux/macOS/WSL users. 

##### Using the Pre-built Binaries

You can also install the prebuilt binaries for Windows found [here](https://arduino.github.io/arduino-cli/1.1/installation/#latest-release)

Check out the `arduino-cli` documentation [here](https://arduino.github.io/arduino-cli/1.1/getting-started/)

#### 2. `gum`

`gum` is a tool developed by the company [Charm](https://charm.sh/) . Check out their gitHub at [Charm's GitHub](https://github.com/charmbracelet)

It makes it easy to create good looking Terminal User Interface (TUI)

To install `gum` 

```bash 
# macOS or Linux
brew install gum

# Arch Linux (btw)
pacman -S gum

# Nix
nix-env -iA nixpkgs.gum

# Flox
flox install gum

# Windows (via WinGet or Scoop)  (Use Linux, or WSL instead of directly installing in Windows)
winget install charmbracelet.gum
scoop install charm-gum
```

For more installation methods , refer the [GitHub repository of `gum`](https://github.com/charmbracelet/gum)

#### 3. `timer`

`timer` is an interactive alternative to the default `sleep` command in linux. It offers an interactive progress bar. 

You can install it using brew as follows 

```bash
brew install caarlos0/tap/timer
```

For other ways to install `timer` checkout it's [Github Repo](https://github.com/caarlos0/timer)

## Usage

Before stating to use `aci` , we need to install the cores required for the basic Arduino boards.

So , go to your terminal and the below commands 

```bash
arduino-cli board listall
arduino-cli core install arduino:avr
```

### To update the app 

#### Using Homebrew
```bash 
brew update && brew upgrade aci
```
#### By Cloning the latest repository 
Delete the folder named `arduino-cli-interactive` from the computer and then 

```bash 
# From GitHub 
git clone https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

# From CodeBerg.org 
git clone https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive.git 

# From Radicle 
## Using git 
git clone https://seed.radicle.garden/z2xtEKkr65SpfQZUQWgqVKSVkfbfw.git arduino-cli-interactive 
## Using Radicle CLI 
rad clone rad:z2xtEKkr65SpfQZUQWgqVKSVkfbfw 

cd bash_shell_script
chmod +x main.sh 
./main.sh 
```

### To Uninstall 

```bash
brew uninstall aci 
brew untap vaishnav-sabari-girish/arduino-cli-interactive
```

Refer the below recording to see it in action

![action](src/images/recordings/full_rec.gif)


The below image gives me the basic repository details in the command line. 

Tool used is `onefetch`

![Repo deets](my_repo_deets.png)

Another tool to give repository details is `tokei`

![Repo deets 2](tokei_output.png)



### Features provided by `aci`


- [x] Select a board
- [x] Create a new Sketch
- [x] Edit the sketch 
- [x] Compile Code
- [x] Upload Code for : 
  - [x] Old Bootloader
  - [x] New Bootloader 
- [x] Install 3rd Party Cores (For ESP8266 and ESP32)
- [x] Install Libraries 
- [x] View Install Libraries 
- [x] Search , compile and upload the examples of the installed libraries 
- [ ] Basic Examples of beginner codes like Blink , print to serial monitor etc. (Expected in future releases). 
- [x] Serial Monitor. (Expected in V1.0.3 or V1.0.4). 
- [ ] TL;DR to make it easier to use `aci` (Expected in future releases)
- [ ] Create a release fo Nushell and Fish (Expected in the future)
- [x] No need to install the dependacies seperately. `aci` does it for you. 

---

#### Legends
- [x] Features present 
- [ ] Features to be added

To access this repository in Github , click [here](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)

To access this repository in Codeberg.org, click [here](https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)

To access this Repository in radicle , click [here](https://app.radicle.xyz/nodes/seed.radicle.garden/rad:z2xtEKkr65SpfQZUQWgqVKSVkfbfw)

To access this repository in Gitea, click [here](https://gitea.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)


# Stargazers over Time 

[![Stargazers over time](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive.svg?variant=dark)](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive)
