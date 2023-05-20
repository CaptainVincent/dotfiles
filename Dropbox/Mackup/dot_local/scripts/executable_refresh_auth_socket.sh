#!/bin/bash

# Remove invalid link files
find "$HOME/.ssh" -type l -name 'tmux-*' -exec sh -c 'test ! -e {} && rm {}' \;

link_by_session_client="$HOME/.ssh/$(basename "$(dirname "$TMUX")")-$(tmux display-message -p "#{session_id}" | tr -d '$')-$(tmux display-message -p "#{client_name}" | tr -d -C '[:digit:]').sock"
link_by_session="$HOME/.ssh/$(basename "$(dirname "$TMUX")")-$(tmux display-message -p "#{session_id}" | tr -d '$').sock"
sock=$(tmux show-environment | grep -o "^SSH_AUTH_SOCK=.*" | cut -d'=' -f2-)
ln -sf "$link_by_session_client" "$link_by_session"
ln -sf "$sock" "$link_by_session_client"
