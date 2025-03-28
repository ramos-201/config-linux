#!/bin/bash

source "$BASE_DIR/utils_base.sh"

log_info "Installing Alacritty..."
if ! output=$(sudo apt install -y alacritty 2>&1); then
  capture_error_output <<< "$output"
  exit 1
fi
log_success "Alacritty installed successfully: $(alacritty -V)"

# Config
CONFIG_DIR="$HOME_DIR/.config/alacritty"
CONFIG_FILE="$CONFIG_DIR/alacritty.toml"

mkdir -p "$CONFIG_DIR"

log_info "Creating the configurations for Alacritty..."
cat "$BASE_DIR/modules/alacritty/alacritty.conf" > "$CONFIG_FILE"

log_success "The installation and configuration of Alacritty completed successfully."
