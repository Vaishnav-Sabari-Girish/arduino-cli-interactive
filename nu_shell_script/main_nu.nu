#!/usr/bin/env fish

let BOARD_NAME = ""
let FQBN_SELECTED = ""
let SERIAL_PORT = ""

let editors = [nano micro gedit vim nvim hx code codium]
let editor_chose = (echo $editors | str join "\n" | gum choose)
echo $editor_chose
