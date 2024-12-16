#!/usr/bin/bash

BOARD_NAME=""
FQBN_SELECTED=""

editors=("nano" "micro" "vim" "nvim" "hx" "code" "codium")
installed_editors=()

sketch_file=""

edit_sketch() {
  echo "Choose file to edit : "
  sketch_file=$(gum file --height 6)
  sleep 0.5
  echo "Choose your preferred editor."
  echo "Note that these editors are already installed in your system"

  sleep 1

  for editor in "${editors[@]}"; do
    if command -v $editor &> /dev/null; then
      installed_editors+=("$editor")
    fi
  done
  
  chosen_editor=$(printf "%s\n" "${installed_editors[@]}" | gum choose)
  sleep 0.5

  $chosen_editor $sketch_file
  
  gum confirm "Check file contents" && gum pager < $sketch_file || main

}

create_new_sketch() {
  arduino-cli sketch new $1
  echo "New Sketch Created"
  echo "At path ${PWD}" | gum style --foreground 47

  sleep 2
  clear
  main
}

upload_code() {
  echo "Select file to be uploaded" 
  #local file_u=$(gum file --height 5)
  echo "Uploaded Sketch" $sketch_file
  gum style --foreground 47 $sketch_file
  
  sleep 2
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
  
  sleep 2
  clear
  main
}

confirm_board_selection() {
  gum confirm "Current Selected Board : $BOARD_NAME" && main || list_installed_boards
}

main() {
  clear

  local intro="Welcome to arduino-cli-interactive"
  echo "$intro" | gum style --foreground 47 --border-foreground 217 --border double --align center --width 50
  echo "You have chosen the board : $BOARD_NAME 
        with FQBN : $FQBN_SELECTED
        Sketch file :  $sketch_file"

  sleep 1
  local choice=$(gum choose "Create New Sketch" "Edit the Sketch" "Compile Code" "Upload Code" "Select Board" "Exit")

  case $choice in 
    "Create New Sketch")
      local sketch_name=$(gum input --placeholder "Enter Name of Sketch")
      create_new_sketch $sketch_name
      ;;
    "Edit the Sketch")
      edit_sketch
      ;;
      
    "Compile Code")
      compile_code
      ;;
    "Upload Code")
      upload_code
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
