#!/bin/bash

[ -n "$1" ] && file=$1
server_path=~/.cache/nvim/godot.pipe

start_server() {
  #nvim --server "$server_path" $file
  kitty -e nvim --listen "$server_path" "$file"
}

open_file_in_server() {
  nvim --server "$server_path" --remote-send ":e $file<CR>:call cursor($2)<CR>"
}

if [ -e ~/.cache/nvim/godot.pipe ]; then
  open_file_in_server "$file" "$2"
else 
  start_server "$file"
fi
