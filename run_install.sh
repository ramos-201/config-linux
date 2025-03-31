#!/bin/bash

# Grant `sudo` permissions
sudo -v

source "./export_global_env.sh"

# zsh
source "./modules/zsh_install.sh"

# Alacritty
source "./modules/alacritty/install.sh"

# Tmux on Alacritty
source "./modules/tmux/install.sh"

