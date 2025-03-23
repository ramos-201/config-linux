#!/bin/bash

source "$BASE_DIR/config_base.sh"

LOG_FILE_ALACRITTY="alacritty.log"

set_log_file "$LOG_FILE_ALACRITTY"

# Reset log file
remove_log_file

log_info "Installing Alacritty..."
if ! output=$(sudo apt install -y not_exist_package 2>&1); then
  capture_error_output <<< "$output"
  exit 1
fi
log_success "Alacritty installed successfully: $(alacritty -V)"
