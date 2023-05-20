#!/bin/bash

if ! tmux has-session 2>/dev/null; then
    # No server running, remove all socket files
    find "$HOME/.ssh" -type l -name 'tmux-*' -delete
else
    # Remove dangling link files
    find "$HOME/.ssh" -type l -name 'tmux-*' |
        while read -r filename; do
            session=$(basename "$filename" | cut -d'-' -f3 | cut -d'.' -f1)
            if ! tmux list-sessions -F '#{session_id}' | tr -d '$' | grep -q "^$session$"; then
                rm "$filename"
            fi
        done
fi
