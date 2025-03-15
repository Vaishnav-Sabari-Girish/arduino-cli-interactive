#!/usr/bin/env bash

BOARD_NAME=""
FQBN_SELECTED=""
SERIAL_PORT=""

editors=("nano" "micro" "gedit" "vim" "nvim" "hx" "code" "codium")
installed_editors=()
sketch_file=""

# Get script directory (handles symlinks correctly)
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_dependencies() {
  missing=()

  for cmd in gum arduino-cli jq; do
    if ! command -v $cmd &>/dev/null; then
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -ne 0 ]; then
    echo "Missing dependencies: ${missing[*]}"
    echo "Please install them before running the script."
    exit 1
  fi
}

serial_monitor() {
  local baud_rate=$(gum input --placeholder "Baud Rate")
  arduino-cli monitor -p "$SERIAL_PORT" -b "$FQBN_SELECTED" --config "$baud_rate"
  trap 'gum confirm "Return to Homepage?" && main || exit' SIGINT

  echo "Press Ctrl+C again"
  while true; do sleep 1; done
}

list_installed_boards() {
  local boards
  boards=$(arduino-cli board listall)
  local selected_line
  selected_line=$(echo "$boards" | gum filter --placeholder "Select a board")

  BOARD_NAME=$(echo "$selected_line" | awk '{print substr($0, 1, index($0, $NF)-1)}' | xargs)
  FQBN_SELECTED=$(echo "$selected_line" | awk '{print $NF}')

  echo "Board Name:" | gum style --foreground 46
  echo "$BOARD_NAME" | gum style --foreground 47
  echo "FQBN:" | gum style --foreground 46
  echo "$FQBN_SELECTED" | gum style --foreground 47

  confirm_board_selection
}

confirm_board_selection() {
  gum confirm "Current Selected Board: $BOARD_NAME" && main || list_installed_boards
}

create_new_sketch() {
  arduino-cli sketch new "$1"
  echo "New Sketch Created"
  echo "At path ${PWD}" | gum style --foreground 47
  sleep 2
  clear
  main
}

edit_sketch() {
  installed_editors=()
  echo "Choose file to edit: "
  sketch_file=$(gum file --height 6)

  for editor in "${editors[@]}"; do
    if command -v "$editor" &>/dev/null; then
      installed_editors+=("$editor")
    fi
  done

  chosen_editor=$(printf "%s\n" "${installed_editors[@]}" | gum choose)
  "$chosen_editor" "$sketch_file"
  gum confirm "Check file contents?" && gum pager <"$sketch_file" || main
}

upload_code() {
  SERIAL_PORT=$(arduino-cli board list | awk '/\/dev\/tty/ {print $1}' | gum choose)
  local bootloader=$(gum choose "Old Bootloader" "New Bootloader")

  case $bootloader in
  "New Bootloader") arduino-cli upload --fqbn "$FQBN_SELECTED" -p "$SERIAL_PORT" "$sketch_file" ;;
  "Old Bootloader") arduino-cli upload --fqbn "${FQBN_SELECTED}:cpu=atmega328old" -p "$SERIAL_PORT" "$sketch_file" ;;
  esac

  echo "Uploaded Sketch: $sketch_file" | gum style --foreground 47
  sleep 2.5
  clear
  main
}

compile_code() {
  gum spin --spinner moon --title "Compiling for $BOARD_NAME" -- arduino-cli compile --fqbn "$FQBN_SELECTED" "$sketch_file" -v
  echo "Compiled Sketch at path" | gum style --foreground 47
  gum confirm "Return to Home?" && main || exit
}

install_libraries() {
  local lib_name
  lib_name=$(gum input --placeholder "Enter Library Name to install")
  local lib_chosen
  lib_chosen=$(arduino-cli lib search "$lib_name" | awk '/Name/ {print $2}' | gum choose)

  arduino-cli lib install "$lib_chosen"
  sleep 2
  main
}

main() {
  clear
  check_dependencies

  echo "Welcome to arduino-cli-interactive" | gum style --foreground 47 --border double --align center --width 50
  echo "Selected Board: $BOARD_NAME
        FQBN: $FQBN_SELECTED
        Sketch File: $sketch_file
        Serial Port: $SERIAL_PORT"

  local choice
  choice=$(gum choose --height 12 "Select Board" "Create New Sketch" "Edit the Sketch" \
    "Compile Code" "Upload Code" "Serial Monitor" "Install Libraries" "Exit")

  case $choice in
  "Create New Sketch") create_new_sketch "$(gum input --placeholder 'Enter Name of Sketch')" ;;
  "Edit the Sketch") edit_sketch ;;
  "Compile Code") compile_code ;;
  "Upload Code") upload_code ;;
  "Serial Monitor") serial_monitor ;;
  "Install Libraries") install_libraries ;;
  "Select Board") list_installed_boards ;;
  "Exit")
    echo "See you again!" | gum style --foreground 47
    exit
    ;;
  *) echo "Unknown option" ;;
  esac
}

main
