#!/bin/bash

source "$BASE_DIR/utils_base.sh"

# Validate previous installation of Alacritty
if ! command -v alacritty &> /dev/null; then
  log_error "Alacritty needs to be installed and configured before Tmux can be installed."
  exit 1
fi

log_info "Installing Tmux..."
if ! output=$(sudo apt install -y tmux 2>&1); then
  capture_error_output <<< "$output"
  exit 1
fi
log_success "Tmux installed successfully: $(tmux -V)"

# Config
CONFIG_FILE="$HOME_DIR/.tmux.conf"

log_info "Creating the configurations for Tmux..."
cat "$BASE_DIR/tmux/tmux.conf" > "$CONFIG_FILE"

log_success "The installation and configuration of Tmux completed successfully."
