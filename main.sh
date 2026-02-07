#!/usr/bin/env bash

############################################
# Dependency check (Fix for Issue #2)
############################################

check_dependency() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo ""
    echo "❌ Missing dependency: $1"
    case "$1" in
      gum)
        echo "👉 Install using: brew install gum  OR  sudo apt install gum"
        ;;
      timer)
        echo "👉 Install using: brew install timer  OR  sudo apt install timer"
        ;;
      arduino-cli)
        echo "👉 Install using: brew install arduino-cli  OR  sudo apt install arduino-cli"
        ;;
    esac
    echo ""
    exit 1
  fi
}

echo "🔍 Checking required dependencies..."
check_dependency gum
check_dependency timer
check_dependency arduino-cli
echo "✅ All required dependencies are installed."
sleep 1

############################################
# Original code starts here (unchanged)
############################################

BOARD_NAME=""
FQBN_SELECTED=""
SERIAL_PORT=""

editors=("nano" "micro" "gedit" "vim" "nvim" "hx" "code" "codium")
installed_editors=()

sketch_file=""

install_dependencies() {
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ -n "$ZSH_VERSION" ]; then
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source ~/.zshrc
    elif [ -n "$BASH_VERSION" ]; then
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source ~/.bashrc
    fi
  fi

  if ! command -v gum &>/dev/null; then
    echo "Installing Gum..."
    brew install gum
  fi

  if ! command -v arduino-cli &>/dev/null; then
    echo "Installing Arduino CLI..."
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
  fi

  if ! command -v timer &>/dev/null; then
    echo "Installing Timer..."
    brew install caarlos0/tap/timer
  fi

  clear
}

serial_monitor() {
  local baud_rate=$(gum input --placeholder "Baud Rate")
  arduino-cli monitor -p $SERIAL_PORT -b $FQBN_SELECTED --config $baud_rate
  trap 'gum confirm "Return to Homepage ?" && main || exit' SIGINT

  echo "Press Ctrl+C again"
  while true; do
    sleep 1
  done
}

check_for_updates() {
  local current_version="v1.2.0"

  if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
    echo "No internet connection. Skipping update check."
    return 0
  fi

  if [ -z "$ACI_GITHUB_TOKEN" ]; then
    echo "Warning: ACI_GITHUB_TOKEN is not set"
    return 1
  fi

  local api_response=$(curl -k -s -H "Authorization: token $ACI_GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/latest")

  local latest_version=$(echo "$api_response" | jq -r '.tag_name')

  if [ "$current_version" != "$latest_version" ]; then
    cat <<EOF
📦 Update available!
Current version: $current_version
Latest version:  $latest_version
To upgrade, run:
    brew upgrade vaishnav-sabari-girish/arduino-cli-interactive
EOF
    return 2
  fi
}

list_libraries() {
  arduino-cli lib list
  gum confirm "Return to homepage ?" && main || :
}

basic_examples() {
  local examples_dir="$(brew --prefix aci)/libexec/examples"
  local basic_example_chosen=$(gum file "$examples_dir")
  gum pager <"$basic_example_chosen"
  sketch_file="$basic_example_chosen"
  main
}

lib_examples() {
  local lib_example=$(arduino-cli lib list | tail -n +2 | awk '{print $1}' | gum filter)
  local example_chosen=$(arduino-cli lib examples "$lib_example" | tail -n +2 | gum choose)
  sketch_file="$example_chosen"
  gum pager <"$example_chosen"
  main
}

edit_config_file() {
  arduino-cli config init
  local chosen_editor=$(printf "%s\n" "${editors[@]}" | gum choose)
  "$chosen_editor" "$HOME/.arduino15/arduino-cli.yaml"
  gum confirm "Check file contents" && gum pager <"$HOME/.arduino15/arduino-cli.yaml" || main
}

edit_sketch() {
  sketch_file=$(gum file)
  local chosen_editor=$(printf "%s\n" "${editors[@]}" | gum choose)
  "$chosen_editor" "$sketch_file"
  gum confirm "Check file contents" && gum pager <"$sketch_file" || main
}

create_new_sketch() {
  arduino-cli sketch new "$1"
  gum style --foreground 47 "New Sketch Created"
  main
}

upload_code() {
  SERIAL_PORT=$(arduino-cli board list | awk '/tty/ {print $1}' | gum choose)
  arduino-cli upload --fqbn "$FQBN_SELECTED" -p "$SERIAL_PORT" "$sketch_file"
  gum style --foreground 47 "Uploaded Sketch"
  main
}

compile_code() {
  gum spin --spinner moon --title "Compiling..." -- arduino-cli compile --fqbn "$FQBN_SELECTED" "$sketch_file" -v
  gum confirm "Return to Home?" && main || exit
}

list_installed_boards() {
  local selected_line=$(arduino-cli board listall | gum filter)
  BOARD_NAME=$(echo "$selected_line" | awk '{print substr($0, 1, index($0, $NF)-1)}' | xargs)
  FQBN_SELECTED=$(echo "$selected_line" | awk '{print $NF}')
  main
}

install_libraries() {
  local lib_name=$(gum input --placeholder "Enter Library Name")
  arduino-cli lib install "$lib_name"
  main
}

main() {
  clear
  install_dependencies

  gum style --foreground 47 --border double --align center --width 50 \
    "Welcome to arduino-cli-interactive"

  local choice=$(gum choose --height 12 \
    "Select Board" \
    "Create New Sketch" \
    "Edit the Sketch" \
    "Compile Code" \
    "Upload Code" \
    "Serial Monitor" \
    "Install Libraries" \
    "Display Installed Libraries" \
    "View Basic Examples" \
    "View Library Examples" \
    "Edit Configurations" \
    "Exit")

  case $choice in
    "Select Board") list_installed_boards ;;
    "Create New Sketch") create_new_sketch "$(gum input)" ;;
    "Edit the Sketch") edit_sketch ;;
    "Compile Code") compile_code ;;
    "Upload Code") upload_code ;;
    "Serial Monitor") serial_monitor ;;
    "Install Libraries") install_libraries ;;
    "Display Installed Libraries") list_libraries ;;
    "View Basic Examples") basic_examples ;;
    "View Library Examples") lib_examples ;;
    "Edit Configurations") edit_config_file ;;
    "Exit") exit ;;
  esac
}

main
