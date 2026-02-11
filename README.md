# Arduino Interactive CLI (aci)

![Banner](banner.png)

[![Release](https://img.shields.io/badge/Release-V1.2.0-blue?style=for-the-badge&labelColor=gray)](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/tag/v1.2.0)
![License](license-apache-2.0.svg)
![Bash Script](made-with-bash.svg)
[![Get it on TUI-Shop](https://img.shields.io/badge/Get%20on-tui--shop-lightgrey?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAxklEQVRoge3Zuw3CMBRGYYzoGYEhIrEGSLTswCywQ0pGyRKMQEthRvCPFF7H56uvnBy5uUrKIlRrrenst5RSSmtm+YkX+SUG0xlMZzCdwXSrdxyabDyvmHPL6+6GDaYzmM5gOoPpyj98q5pTdzdsMJ3BdAbTGUwXf9M6nm7xoeNlE82lS951GKK5wzQ1Z7q7YYPpDKYzmM5gunjTWu938aH1nG1Q6U/Gx30bP7uluxs2mM5gOoPpDKbz7yGdwXQG0xlMZzDdE3J4HtdWbCB+AAAAAElFTkSuQmCC)](https://github.com/Gcat101/Tui-shop)
![basher install](https://www.basher.it/assets/logo/basher_install.svg)
[![TerminalTrove](https://img.shields.io/badge/Available%20on-TerminalTrove-brightgreen?style=for-the-badge)](https://terminaltrove.com/arduino-cli-interactive/)

> A user-friendly interactive CLI tool that bridges the gap between Arduino IDE and arduino-cli, perfect for developers transitioning to command-line workflows.

## Overview

Arduino Interactive CLI (`aci`) is designed for developers who want to harness the power of `arduino-cli` without the intimidation of raw command-line interfaces. It provides an intuitive, menu-driven experience while maintaining the efficiency and control of CLI workflows.

**Perfect for:**
- Developers transitioning from Arduino IDE to CLI
- Advanced users seeking faster workflows
- Anyone who wants a polished TUI experience for Arduino development

## Features

### Current Features ✅
- **Board Management**: Select and configure Arduino boards with ease
- **Sketch Operations**: Create, edit, compile, and upload sketches
- **Bootloader Support**: Upload for both old and new bootloaders
- **Library Management**: 
  - Install libraries from the Arduino ecosystem
  - View installed libraries
  - Search and compile library examples
- **Core Installation**: Support for ESP8266, ESP32, and other 3rd-party cores
- **Serial Monitor**: Built-in serial communication (V1.0.3+)
- **Auto-dependency Management**: Automatically installs required tools
- **Beginner-Friendly Examples**: Built-in starter code (Blink, Serial, etc.)

### Coming Soon 🚧
- TL;DR documentation for quick reference
- Nushell and Fish shell support

## Quick Start

Try before installing:

```bash
curl -sSL https://raw.githubusercontent.com/Vaishnav-Sabari-Girish/arduino-cli-interactive/refs/heads/main/bash_shell_script/main.sh | bash
```

## Installation

### Recommended: Homebrew

The easiest installation method with automatic dependency management:

```bash
brew install vaishnav-sabari-girish/arduino-cli-interactive/aci
```

**First-time setup:**

1. Create a GitHub Personal Access Token (PAT) for update notifications:
   - Visit [GitHub Token Settings](https://github.com/settings/tokens)
   - Create a "Tokens (Classic)" with `repo` permissions
   
2. Add to your shell configuration (`~/.bashrc` or `~/.zshrc`):
   ```bash
   export ACI_GITHUB_TOKEN="your_token_here"
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

### Alternative: Basher

For Bash script package manager users:

```bash
basher install Vaishnav-Sabari-Girish/arduino-cli-interactive
```

Run with: `aci.sh`

**Note:** Manual installation of dependencies required: `gum`, `timer`, `arduino-cli`, and `homebrew`. If using Basher, ensure Homebrew is installed and added to your PATH.

**To upgrade:**
```bash
basher uninstall Vaishnav-Sabari-Girish/arduino-cli-interactive
basher install Vaishnav-Sabari-Girish/arduino-cli-interactive
```

### From Source

Clone from your preferred platform:

```bash
# GitHub
git clone https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

# Codeberg
git clone https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

# Gitea
git clone https://gitea.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git

cd bash_shell_script
chmod +x main.sh
./main.sh
```

Add to your shell configuration:

```bash
alias aci="/path/to/arduino-cli-interactive/bash_shell_script/main.sh"
```

Then reload: `source ~/.bashrc` or `source ~/.zshrc`

## Prerequisites

**Note:** Homebrew installation handles dependencies automatically. Manual installation only needed if installing from source or using Basher.

### 1. arduino-cli

**Recommended: Homebrew**

If you don't have Homebrew installed:

**macOS/Linux:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Windows Users:** Use Windows Subsystem for Linux (WSL) and follow Linux instructions. Learn WSL: [NetworkChuck's WSL Tutorial](https://youtu.be/vxTW22y8zV8?si=mZ5w9KmT0A4_d7Zr)

After installing Homebrew:
```bash
brew update
brew install arduino-cli
```

**Alternative: Installation Script** (Linux/macOS/WSL only)
```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

**Pre-built Binaries:** Available at [arduino-cli releases](https://arduino.github.io/arduino-cli/1.1/installation/#latest-release)

📚 [arduino-cli Documentation](https://arduino.github.io/arduino-cli/1.1/getting-started/)

### 2. gum

A TUI framework by [Charm](https://charm.sh/):

```bash
# macOS or Linux
brew install gum

# Arch Linux
pacman -S gum

# Nix
nix-env -iA nixpkgs.gum

# Flox
flox install gum

# Windows (via WinGet or Scoop) - WSL recommended
winget install charmbracelet.gum
scoop install charm-gum
```

🔗 [gum GitHub Repository](https://github.com/charmbracelet/gum)

### 3. timer

Interactive progress bar alternative to `sleep`:

```bash
brew install caarlos0/tap/timer
```

🔗 [timer GitHub Repository](https://github.com/caarlos0/timer)

## Usage

### Initial Setup

Install Arduino AVR core for basic boards:

```bash
arduino-cli board listall
arduino-cli core install arduino:avr
```

### Running aci

Simply type `aci` in your terminal (or `aci.sh` if installed via Basher).

![Demo](src/images/recordings/full_rec.gif)

## Updating

### Homebrew
```bash
brew update && brew upgrade aci
```

### From Source
```bash
# Delete old installation, then:
git clone https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git
cd bash_shell_script
chmod +x main.sh
./main.sh
```

### Basher
```bash
basher uninstall Vaishnav-Sabari-Girish/arduino-cli-interactive
basher install Vaishnav-Sabari-Girish/arduino-cli-interactive
```

## Uninstalling

```bash
brew uninstall aci
brew untap vaishnav-sabari-girish/arduino-cli-interactive
```

## Documentation

- 📖 [GitHub Pages](https://vaishnav-sabari-girish.github.io/arduino-cli-interactive/)
- 📖 [Codeberg Pages](https://vaishnav-sabari-girish.codeberg.page/pages/intro.html)

## Repository Information

![Repo Details](my_repo_deets.png)
![Tokei Output](tokei_output.png)

*Generated using `onefetch` and `tokei`*

## Contributing

We welcome contributions! Please see our guidelines:

- [Contributor Guidelines](./OSCG_CONTRIBUTOR_Guidelines.md)
- [Mentor Guidelines](./OSCG_MENTOR_Guidelines.md)

## Community & Links

[![GitHub](https://img.shields.io/badge/GitHub-181717.svg?style=for-the-badge&logo=GitHub&logoColor=white)](https://github.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)
[![Codeberg](https://img.shields.io/badge/Codeberg-2185D0.svg?style=for-the-badge&logo=Codeberg&logoColor=white)](https://codeberg.org/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)
[![Gitea](https://img.shields.io/badge/Gitea-609926.svg?style=for-the-badge&logo=Gitea&logoColor=white)](https://gitea.com/Vaishnav-Sabari-Girish/arduino-cli-interactive.git)

**Featured On:**
- [awesome-tuis](https://github.com/rothgar/awesome-tuis?tab=readme-ov-file#miscellaneous)
- [TerminalTrove.com](https://terminaltrove.com/arduino-cli-interactive/)

## License

Licensed under Apache 2.0

---

## Stargazers over Time

[![Stargazers over time](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive.svg?variant=dark)](https://starchart.cc/Vaishnav-Sabari-Girish/arduino-cli-interactive)
