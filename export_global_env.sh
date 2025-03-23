#!/bin/bash

search_dir=$(pwd)

while [[ "$search_dir" != "/" ]]; do
    if [[ -f "$search_dir/export_global_env.sh" ]]; then
        export BASE_DIR="$search_dir"
        break
    fi
    search_dir=$(dirname "$search_dir")
done

export HOME_DIR="$HOME"
