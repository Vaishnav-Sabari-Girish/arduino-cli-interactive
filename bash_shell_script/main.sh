#!/usr/bin/bash

BOARD_NAME=""
FQBN_SELECTED=""


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
  local file_chosen_u=$(gum file --height 5)
  echo "Uploaded Sketch" $file_chosen_u
  gum style --foreground 47 $file_chosen_u 
  
  sleep 2
  clear
  main
}

compile_code() {
  echo "Select file to be compiled"
  local file_chosen_c=$(gum file --height 5)
  echo "Compiled Sketch at path" 
  gum style --foreground 47 $file_chosen_c 

  sleep 2
  clear
  main
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
        with FQBN : $FQBN_SELECTED"

  sleep 1
  local choice=$(gum choose "Create New Sketch" "Compile Code" "Upload Code" "List Boards" "Exit")

  case $choice in 
    "Create New Sketch")
      local sketch_name=$(gum input --placeholder "Enter Name of Sketch")
      create_new_sketch $sketch_name
      ;;
    "Compile Code")
      compile_code
      ;;
    "Upload Code")
      upload_code
      ;;
    "List Boards")
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
