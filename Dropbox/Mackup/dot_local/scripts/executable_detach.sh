#!/bin/bash

# Remove invalid link files
find "$HOME/.ssh" -type l -name 'tmux-*' -exec sh -c 'test ! -e {} && rm {}' \;

# Although this hook is broadcasted to execute in all sessions,
# here we only want to handle the case where two or more clients are attached to the same session.
# We aim to relink to the SSH_AUTH_SOCK link created by the client that is still attached.
link_by_session_client="$HOME/.ssh/$(basename "$(dirname "$TMUX")")-$(tmux display-message -p "#{session_id}" | tr -d '$')-$(tmux display-message -p "#{client_name}" | tr -d -C '[:digit:]').sock"
link_by_session="$HOME/.ssh/$(basename "$(dirname "$TMUX")")-$(tmux display-message -p "#{session_id}" | tr -d '$').sock"
if [ -e "$link_by_session_client" ]; then
    ln -sf "$link_by_session_client" "$link_by_session"
fi
