function tsesh() {
  local session_name="$1"
  local current_dir="$PWD"

  if [[ -z "$session_name" ]]; then
    echo "Usage: tsesh <session_name>"
    return 1
  fi

  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    return 0
  fi

  tmux new-session -d -s "$session_name" -c "$current_dir" -n code
  tmux send-keys -t "$session_name":0 "cd \"$current_dir\"" C-m

  tmux new-window -t "$session_name" -c "$current_dir" -n shell
  tmux send-keys -t "$session_name":1 "cd \"$current_dir\"" C-m

  tmux new-window -t "$session_name" -c "$current_dir" -n chat
  tmux send-keys -t "$session_name":2 "cd \"$current_dir\"" C-m

  tmux select-window -t "$session_name":0
  tmux attach-session -t "$session_name"
}
