#!/bin/bash

# Request password
sudo -v

# Color for reading logs
_COLOR_RESET=$(tput sgr0)
_COLOR_INFO=$(tput setaf 6)
_COLOR_SUCCESS=$(tput setaf 2)
_COLOR_WARNING=$(tput setaf 3)
_COLOR_ERROR=$(tput setaf 1)

[ -z "$BASE_DIR" ] && echo "${_COLOR_ERROR}ERROR: BASE_DIR no defined. Load 'export_global_env.sh' first. ${_COLOR_RESET}" && exit 1
LOGS_DIR="$BASE_DIR/logs"
mkdir -p "$LOGS_DIR"

log_file=""

set_log_file() {
  if [[ ! "$1" =~ \.log$ ]]; then
    echo -e "${_COLOR_ERROR} ERROR: The log file must have a .log extension. ${_COLOR_RESET}"
    return 1
  fi
  log_file="$LOGS_DIR/$1"
}

# Register logs
_log() {
  if [[ -z "$log_file" ]]; then
    echo -e "${_COLOR_ERROR} ERROR: No log file set. Use 'set_log_file' first. ${_COLOR_RESET}"
    return 1
  fi

  local level="$1"
  local color="$2"
  local message="$3"

  echo "${color}[$level] ${message} ${_COLOR_RESET}" | tee -a "$log_file"
}

log_info() { _log "INFO" "$_COLOR_INFO" "$1"; }
log_success() { _log "SUCCESS" "$_COLOR_SUCCESS" "$1"; }
log_error() { _log "ERROR" "$_COLOR_ERROR" "$1"; }
log_warning() { _log "WARNING" "$_COLOR_WARNING" "$1"; }

remove_log_file() {
  if [[ "$log_file" ]]; then
    rm -rf "$log_file"
  else
    echo "${_COLOR_ERROR} ERROR: No file was removed because it is not defined. Use 'set_log_file'. ${_COLOR_RESET}"
    return 1
  fi
}

# Captures errors when reading output
#
# Example usage:
# if ! output=$(sudo apt install -y not_exist_package 2>&1); then
#   capture_error_output <<< "$output"
#   exit 1
# fi
#
# Output: $log_file
# .
# .
# [ERROR] E: The package not_exist_package could not be located.
#
# This function reads the error output and passes it to the log_error function.
capture_error_output() {
  while IFS= read -r line; do
    log_error "$line"
  done
}
