#!/bin/bash

source "$LIBRARY_DIR/utilities/extract_json_string_attr.sh"
source "$LIBRARY_DIR/utilities/extract_json_array.sh"

# Use the path from the environment variable, or default to a known location
CONFIG_FILE="${ENV_CONFIG_PATH:-/default/path/to/env_config.json}"

# Check if the JSON configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Load and export the environment variables from the JSON file
export PROJECT_DIR=$(extract_json_string_attr "PROJECT_DIR" "$CONFIG_FILE")