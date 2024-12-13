- [Arduino Interactive CLI](#arduino-interactive-cli)
    + [Pre-requisites](#pre-requisites)
      - [1. `arduino-cli`](#1--arduino-cli-)
        * [Homebrew](#homebrew)
          + [macOS/Linux](#macos-linux)
          + [For windows users](#for-windows-users)
        * [Installing `arduino-cli` using the installation script](#installing--arduino-cli--using-the-installation-script)
        * [Using the Pre-built Binaries](#using-the-pre-built-binaries)
      - [2. `gum`](#2--gum-)


# Arduino Interactive CLI

This tool is made specifically for those who want to transition from the Arduino IDE to the CLI , but are still scared or intimidated by the command line. 

### Pre-requisites

#### 1. `arduino-cli` 

There are many ways to install arduino-cli. I recommend Homebrew , because all the other prerequisite tools are also available on homebrew. 

##### Homebrew 

In case you do not have Homebrew installed in your system 

###### macOS/Linux

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

###### For windows users

Use Windows Subsystem for Linux (WSL) and follow the instructions for Linux.

To learn to use WSL , the best video is by [NetwokChuck](https://youtu.be/vxTW22y8zV8?si=mZ5w9KmT0A4_d7Zr)

<br>

After installing Homebrew , go to your terminal and just type this 

```bash
brew update
brew install arduino-cli
```
##### Installing `arduino-cli` using the installation script

If you do not want to use homebrew , you can copy and paste this installation script 

`curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh`

**NOTE** : This script in only for Linux/macOS/WSl users. 

##### Using the Pre-built Binaries

You can also install the prebuilt binaries for Windows found [here](https://arduino.github.io/arduino-cli/1.1/installation/#latest-release)

#### 2. `gum`

`gum` is a tool developed by the company [Charm](https://charm.sh/) . Check out their gitHub at (Charm's GitHub)[https://github.com/charmbracelet]

It makes it easy to create good looking Terminal User Interface (TUI)

To install `gum` 

<details>
  <summary><h5>Using Package Managers</h5></summary>
    
    ```bash 

    # macOS or Linux
    brew install gum

    # Arch Linux (btw)
    pacman -S gum

    # Nix
    nix-env -iA nixpkgs.gum

    # Flox
    flox install gum

    # Windows (via WinGet or Scoop)
    winget install charmbracelet.gum
    scoop install charm-gum
    ```
</details>

For more installation methods , refer the [GitHub repository of `gum`](https://github.com/charmbracelet/gum)


                        ## Stargazers over time
[![Stargazers over time](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive.svg?variant=adaptive)](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive)
                    
