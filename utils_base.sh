#!/bin/bash

# Color definitions for logs
_COLOR_RESET=$(tput sgr0)
_COLOR_INFO=$(tput setaf 6)
_COLOR_SUCCESS=$(tput setaf 2)
_COLOR_WARNING=$(tput setaf 3)
_COLOR_ERROR=$(tput setaf 1)

# Ensure `BASE_DIR` is set
if [ -z "$BASE_DIR" ]; then
  echo -e "${_COLOR_ERROR}ERROR: BASE_DIR is not defined. Load 'export_global_env.sh' first. ${_COLOR_RESET}"
  exit 1
fi

# Define logs directory and log file
_LOGS_DIR="$BASE_DIR/logs"
mkdir -p "$_LOGS_DIR"

_LOG_FILE="$_LOGS_DIR/history.log"

# Reset log file
rm -rf "$_LOG_FILE"

# Add log messages
_add_log() {
  local level="$1"
  local color="$2"
  local message="$3"

  echo -e "${color}[$level] ${message} ${_COLOR_RESET}" | tee -a "$_LOG_FILE"
}

# Capture log
log_info()    { _add_log "INFO"    "$_COLOR_INFO"    "$1"; }
log_success() { _add_log "SUCCESS" "$_COLOR_SUCCESS" "$1"; }
log_error()   { _add_log "ERROR"   "$_COLOR_ERROR"   "$1"; }
log_warning() { _add_log "WARNING" "$_COLOR_WARNING" "$1"; }


# Capture errors from command outputs
capture_error_output() {
  while IFS= read -r line; do
    log_error "$line"
  done
}
# Example usage:
# if ! output=$(sudo apt install -y not_exist_package 2>&1); then
#   capture_error_output <<< "$output"
#   exit 1
# fi
#
# Output in logs:
# [ERROR] E: The package not_exist_package could not be located.
