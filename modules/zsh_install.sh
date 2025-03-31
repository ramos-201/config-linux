#!/bin/bash

source "$BASE_DIR/utils_base.sh"

log_info "Installing ZSH..."
if ! output=$(sudo apt install -y zsh 2>&1); then
  capture_error_output <<< "$output"
  exit 1
fi
log_success "Zsh installed successfully: $(zsh --version)"

# Set as default
sudo chsh -s "$(which zsh)" "$USER"

log_success "The installation and configuration of Zsh completed successfully."
