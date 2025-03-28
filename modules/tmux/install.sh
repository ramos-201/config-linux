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
cat "$BASE_DIR/modules/tmux/tmux.conf" > "$CONFIG_FILE"

# Tmux configuration on Alacritty
CONFIG_DIR_ALACRITTY="$HOME_DIR/.config/alacritty"
CONFIG_FILE_ALACRITTY="$CONFIG_DIR_ALACRITTY/alacritty.toml"

# Validate if the configurations for Alacritty exist
if ! [[ -f "$CONFIG_FILE_ALACRITTY" ]]; then
  log_warning "You need to have Alacritty configured. First, add `.config/alacritty/alacritty.toml` and add the Tmux settings."
  exit 1
fi

# Validates if Tmux configurations already exist in Alacritty
if grep -q "\[shell\]" "$CONFIG_FILE_ALACRITTY"; then
  log_warning "Alacritty configuration for Tmux was skipped as it was already set in a previous installation."
else
  log_info "Adding Tmux configuration to Alacritty..."
  cat "$BASE_DIR/modules/tmux/tmux_alacritty.conf" >> "$CONFIG_FILE_ALACRITTY"
fi

log_success "The installation and configuration of Tmux completed successfully."
