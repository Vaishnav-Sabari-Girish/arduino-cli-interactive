#!/usr/bin/env bash

BOARD_NAME=""
FQBN_SELECTED=""
SERIAL_PORT=""

editors=("nano" "micro" "gedit" "vim" "nvim" "hx" "code" "codium")
installed_editors=()

sketch_file=""

run_timer() {
  if command -v timer &>/dev/null; then
    timer "$1"
  else
    sleep "${1%s}"
  fi
}

install_dependencies() {
  # Check if Homebrew is installed
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
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

  # Install Gum
  #
  if ! command -v gum &>/dev/null; then
    echo "Installing Gum..."
    brew install gum
  fi

  # Install Arduino CLI
  if ! command -v arduino-cli &>/dev/null; then
    echo "Installing Arduino CLI..."
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
  fi

  # Install Timer
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

  # Check if the system is online by pinging Google
  if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
    echo "No internet connection. Skipping update check."
    return 0 # Proceed to main program
  fi

  # First check if GitHub token is set
  if [ -z "$ACI_GITHUB_TOKEN" ]; then
    echo "Warning: ACI_GITHUB_TOKEN is not set" >&2
    echo "Please set your GitHub token with: export ACI_GITHUB_TOKEN='your_token_here'" >&2
    return 1
  fi

  # Get the latest version with error checking and store full response
  # Added -k to skip SSL verification
  local api_response=$(curl -k -s -H "Authorization: token $ACI_GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/latest")

  # Store the curl exit code
  local curl_exit_code=$?

  # Check if curl command succeeded
  if [ $curl_exit_code -ne 0 ]; then
    echo "Error: Failed to fetch latest version information (Exit code: $curl_exit_code)" >&2
    return 1
  fi

  # Check if response is empty
  if [ -z "$api_response" ]; then
    echo "Error: Empty response from GitHub API" >&2
    return 1
  fi

  # Check if response is valid JSON
  if ! echo "$api_response" | jq empty >/dev/null 2>&1; then
    echo "Error: Invalid JSON response from GitHub API" >&2
    echo "Raw response: $api_response" >&2
    return 1
  fi

  # Try to extract the version
  local latest_version=$(echo "$api_response" | jq -r '.tag_name')

  # Check if version was extracted successfully
  if [ -z "$latest_version" ] || [ "$latest_version" = "null" ]; then
    echo "Error: Could not find version tag in response" >&2
    echo "Raw response: $api_response" >&2
    return 1
  fi

  if [ "$current_version" != "$latest_version" ]; then
    cat >&2 <<-EOF
📦 Update available!
Current version: $current_version
Latest version:  $latest_version
To upgrade, run:
    brew upgrade vaishnav-sabari-girish/arduino-cli-interactive
EOF
    return 2 # Return code 2 indicates update available
  fi

  return 0 # Return code 0 indicates up to date
}

list_libraries() {
  echo "These are the libraries installed in your system"
  printf "\n"
  arduino-cli lib list

  gum confirm "Return to homepage ?" && main || :
}

basic_examples() {
  installed_editors=()

  local examples_dir="$(brew --prefix aci)/libexec/examples"
  local basic_example_chosen=$(gum file $examples_dir)

  gum pager <$basic_example_chosen
  sketch_file=$basic_example_chosen

  main
}

lib_examples() {
  installed_editors=()

  local lib_example=$(arduino-cli lib list | tail -n +2 | awk '{print $1, $2}' |
    sed 's/  *[0-9][^ ]*//g' |
    sed 's/-//g' | gum filter --placeholder "Input Library name to get example" --indicator=">")
  local example_chosen=$(arduino-cli lib examples $lib_example | tail -n +2 | awk 'NF' | gum choose)

  local lib_dir=$(echo $example_chosen | sed 's/^[[:space:]-]*//')

  local ex_file=$(gum file $lib_dir)

  gum pager <$ex_file
  sketch_file=("${lib_dir}${ex_file}")

  main

}

edit_config_file() {
  if [ -e $HOME/.arduino15/arduino-cli.yaml ]; then
    arduino-cli config init
  fi

  installed_editors=()

  echo "Choose your preferred editor."
  echo "Note that these editors are already installed in your system"

  run_timer 1s

  for editor in "${editors[@]}"; do
    if command -v $editor &>/dev/null; then
      installed_editors+=("$editor")
    fi
  done

  chosen_editor=$(printf "%s\n" "${installed_editors[@]}" | gum choose)
  run_timer 0.5s

  $chosen_editor "$HOME/.arduino15/arduino-cli.yaml"

  gum confirm "Check file contents" && gum pager <$HOME/.arduino15/arduino-cli.yaml || main

}

edit_sketch() {
  installed_editors=()

  echo "Choose file to edit : "
  sketch_file=$(gum file --height 6)
  run_timer 0.5s
  echo "Choose your preferred editor."
  echo "Note that these editors are already installed in your system"

  run_timer 1s

  for editor in "${editors[@]}"; do
    if command -v $editor &>/dev/null; then
      installed_editors+=("$editor")
    fi
  done

  chosen_editor=$(printf "%s\n" "${installed_editors[@]}" | gum choose)
  run_timer 0.5

  "$chosen_editor" "$sketch_file"

  gum confirm "Check file contents" && gum pager <"$sketch_file" || main

}

create_new_sketch() {
  arduino-cli sketch new $1
  echo "New Sketch Created"
  echo "At path ${PWD}" | gum style --foreground 47

  run_timer 2s
  clear
  main
}

upload_code() {
  #local file_u=$(gum file --height 5)
  echo "Select Serial port to which the board is connected"
  SERIAL_PORT=$(arduino-cli board list | awk '/\/dev\/tty/ {print $1}' | gum choose)
  echo "Is your bootloader old (mostly for Nano) or the latest one"
  local booltoader_old_new=$(gum choose "Old Bootloader" "New Bootloader")

  case $booltoader_old_new in
  "New Bootloader")
    arduino-cli upload --fqbn $FQBN_SELECTED -p $SERIAL_PORT $sketch_file
    ;;
  "Old Bootloader")
    arduino-cli upload --fqbn "${FQBN_SELECTED}:cpu=atmega328old" -p $SERIAL_PORT $sketch_file
    ;;
  *)
    echo "Invalid Option"
    ;;
  esac
  echo "Uploaded Sketch" $sketch_file
  gum style --foreground 47 $sketch_file

  run_timer 2.5s
  clear
  main
}

compile_code() {
  echo "Select file to be compiled"
  #local file_c=$(gum file --height 5)
  gum spin --spinner moon --title "Compiling for $BOARD_NAME" -- arduino-cli compile --fqbn $FQBN_SELECTED $sketch_file -v
  echo "Compiled Sketch at path"
  gum style --foreground 47 $sketch_file

  gum confirm "Return to Home?" && main || exit
}

list_installed_boards() {
  local boards=$(arduino-cli board listall)
  local selected_line=$(echo "$boards" | gum filter --placeholder "Select a board")

  BOARD_NAME=$(echo "$selected_line" | awk '{print substr($0, 1, index($0, $NF)-1)}' | xargs)
  FQBN_SELECTED=$(echo "$selected_line" | awk '{print $NF}')

  echo "Board Name:" | gum style --foreground 46
  echo "$BOARD_NAME" | gum style --foreground 47
  echo "FQBN:" | gum style --foreground 46
  echo "$FQBN_SELECTED" | gum style --foreground 47

  confirm_board_selection

  run_timer 2s
  clear
  main
}

confirm_board_selection() {
  gum confirm "Current Selected Board : $BOARD_NAME" && main || list_installed_boards
}

install_libraries() {
  local lib_name=$(gum input --placeholder "Enter Library Name to install")
  local lib_chosen=$(arduino-cli lib search $lib_name | awk '
  /Name/ {name=$2}
  /Author/ {
      author="";
      for(i=2; i<=NF; i++){
        if($i ~ /</) 
          break;
        author=author " " $i;
      }
      print name,  " : ", author; 
    }
  ' | gum choose)

  local lib_to_install=$(echo "$lib_chosen" | awk -F' : ' '{print $1}' | tr -d '"')
  arduino-cli lib install $lib_to_install
  run_timer 2s
  main
}

main() {
  clear
  install_dependencies

  check_for_updates
  local intro="Welcome to arduino-cli-interactive"
  echo "$intro" | gum style --foreground 47 --border-foreground 217 --border double --align center --width 50
  echo "You have chosen the board : $BOARD_NAME 
        with FQBN : $FQBN_SELECTED
        Sketch file :  $sketch_file
        Serial Port : $SERIAL_PORT"

  run_timer 1s
  local choice=$(gum choose --height 12 "Select Board" "Create New Sketch" "Edit the Sketch" \
    "Compile Code" "Upload Code" "Serial Monitor" "Install Libraries" "Display Installed Libraries" \
    "View Basic Examples" "View Library Examples" "Edit Configurations" "Exit")

  case $choice in
  "Create New Sketch")
    local sketch_name=$(gum input --placeholder "Enter Name of Sketch")
    create_new_sketch $sketch_name
    ;;
  "Edit the Sketch")
    edit_sketch
    ;;

  "Edit Configurations")
    edit_config_file
    ;;
  "Compile Code")
    compile_code
    ;;
  "Upload Code")
    upload_code
    ;;
  "Serial Monitor")
    serial_monitor
    ;;
  "Install Libraries")
    install_libraries
    ;;
  "Display Installed Libraries")
    list_libraries
    ;;
  "View Basic Examples")
    basic_examples
    ;;
  "View Library Examples")
    lib_examples
    ;;
  "Select Board")
    list_installed_boards
    ;;
  "Exit")
    echo "See you again !!!" | gum style --foreground 47
    exit
    ;;
  *)
    echo "Unknown option"
    ;;
  esac
}

main
