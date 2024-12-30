#!/usr/bin/bash

BOARD_NAME=""
FQBN_SELECTED=""

editors=("nano" "micro" "gedit" "vim" "nvim" "hx" "code" "codium")
installed_editors=()

sketch_file=""

check_for_updates() {
  local current_version="v1.0.3"
  local latest_version=$( curl -s https://api.github.com/repos/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/latest | jq -r '.tag_name')

  if test $current_version != $latest_version 
  then 
    cat >&2 <<EOF

📦 Update available!
Current version: $current_version
Latest version:  $latest_version

To upgrade, run:
    brew upgrade Vaishnav-Sabari-Girish/arduino-cli-interactive

EOF
            return 2  # Return code 2 indicates update available
    fi

    return 0  # Return code 0 indicates up to date
}

list_libraries(){
  echo "These are the libraries installed in your system"
  printf "\n"
  arduino-cli lib list

  gum confirm "Return to homepage ?" && main || :
}

lib_examples() {
  installed_editors=()

  local lib_example=$(arduino-cli lib list | tail -n +2 | awk '{print $1, $2}' \
    | sed 's/  *[0-9][^ ]*//g' \
    | sed 's/-//g' | gum filter --placeholder "Input Library name to get example" --indicator=">") 
  local example_chosen=$(arduino-cli lib examples $lib_example | tail -n +2 |  awk 'NF' | gum choose)
  
  local lib_dir=$(echo $example_chosen | sed 's/^[[:space:]-]*//')
  
  local ex_file=$(gum file $lib_dir)

  gum pager < $ex_file
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

  sleep 1

  for editor in "${editors[@]}"; do
    if command -v $editor &> /dev/null; then
      installed_editors+=("$editor")
    fi
  done
  
  chosen_editor=$(printf "%s\n" "${installed_editors[@]}" | gum choose)
  sleep 0.5

  $chosen_editor $HOME/.arduino15/arduino-cli.yaml

 gum confirm "Check file contents" && gum pager <  $HOME/.arduino15/arduino-cli.yaml || main

}


edit_sketch() {
  installed_editors=()

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
  #local file_u=$(gum file --height 5)
  echo "Select Serial port to which the board is connected"
  local serial_port=$(arduino-cli board list | awk '/\/dev\/tty/ {print $1}' | gum choose)
  echo "Is your bootloader old (mostly for Nano) or the latest one"
  local booltoader_old_new=$(gum choose "Old Bootloader" "New Bootloader")
  
  case $booltoader_old_new in 
    "New Bootloader")
      arduino-cli upload --fqbn $FQBN_SELECTED -p $serial_port $sketch_file
      ;;
    "Old Bootloader")
      arduino-cli upload --fqbn "${FQBN_SELECTED}:cpu=atmega328old" -p $serial_port $sketch_file
      ;;
    *)
      echo "Invalid Option"
      ;;
  esac
  echo "Uploaded Sketch" $sketch_file
  gum style --foreground 47 $sketch_file
  
  sleep 4
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
  main 
}

main() {
  clear

  check_for_updates
  local intro="Welcome to arduino-cli-interactive"
  echo "$intro" | gum style --foreground 47 --border-foreground 217 --border double --align center --width 50
  echo "You have chosen the board : $BOARD_NAME 
        with FQBN : $FQBN_SELECTED
        Sketch file :  $sketch_file"

  sleep 1
  local choice=$(gum choose "Select Board" "Create New Sketch" "Edit the Sketch"\
    "Compile Code" "Upload Code" "Install Libraries" "Display Installed Libraries"\
    "View Examples" "Edit Configurations" "Exit")

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
    "Install Libraries")
      install_libraries
      ;;
    "Display Installed Libraries")
      list_libraries
      ;;
    "View Examples")
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
