#!/bin/bash

source "$BASE_DIR/utils_base.sh"

LOG_FILE_TMUX="tmux.log"

set_log_file "$LOG_FILE_TMUX"

# Reset log file
remove_log_file

log_info "Installing Tmux..."
if ! output=$(sudo apt install -y tmux 2>&1); then
  capture_error_output <<< "$output"
  exit 1
fi
log_success "Tmux installed successfully: $(tmux -V)"
