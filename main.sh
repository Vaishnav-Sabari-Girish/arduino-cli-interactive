list_installed_boards() {
  # Get connected boards
  local connected=$(arduino-cli board list | awk 'NR>1 && NF')

  if [ -n "$connected" ]; then
    echo "Detected Connected Boards:"
    echo "$connected"

    local selected_line=$(echo "$connected" | gum choose)
  else
    echo "No connected boards detected. Showing all available boards."
    local boards=$(arduino-cli board listall)
    local selected_line=$(echo "$boards" | gum filter --placeholder "Select a board")
  fi

  BOARD_NAME=$(echo "$selected_line" | awk '{print substr($0, 1, index($0, $NF)-1)}' | xargs)
  FQBN_SELECTED=$(echo "$selected_line" | awk '{print $NF}')

  echo "Board Name:" | gum style --foreground 46
  echo "$BOARD_NAME" | gum style --foreground 47
  echo "FQBN:" | gum style --foreground 46
  echo "$FQBN_SELECTED" | gum style --foreground 47

  confirm_board_selection

  timer 2s
  clear
  main
}