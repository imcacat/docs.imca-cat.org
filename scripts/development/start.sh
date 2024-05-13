#!/bin/sh

# Function to dynamically determine the project root and script directory
get_script_dir() {
    # Resolve the directory of this script
    script_path="$0"
    if [ -h "$script_path" ]; then
        # Handle symbolic link
        script_path=$(ls -l "$script_path" | awk '{ print $NF }')
    fi
    script_dir=$(dirname "$script_path")
    cd "$script_dir" && pwd
}

# Determine the project root directory assuming the script is in the 'scripts/development' sub-directory
PROJECT_DIR=$(cd "$(get_script_dir)/../.." && pwd)
DOCUFY_SH="$PROJECT_DIR/scripts/docufy.sh"

# Default configuration file should be set to the project root
config_file="$PROJECT_DIR/_config.development.yml"

# Function to list configuration files and their URLs
list_configs() {
    echo "Available configuration files and their URLs:"
    for config in "$PROJECT_DIR"/*.yml "$PROJECT_DIR"/*.yaml; do
        if [ -f "$config" ]; then
            # Extract the URL using awk, handling different spacing and ensuring only the URL is captured
            url=$(awk -F': ' '/^url[[:space:]]*:/ {print $2; exit}' "$config" | tr -d '"' | cut -d' ' -f1)
            if [ -z "$url" ]; then
                url="URL not set or malformed in file"
            fi
            echo "$(basename "$config") - URL: $url"
        fi
    done
}

# Function to display an interactive menu to choose configuration file
interactive_menu() {
    echo "Select a configuration file by number:"
    local i=1
    local file
    local files_list=""
    for config in "$PROJECT_DIR"/*.yml "$PROJECT_DIR"/*.yaml; do
        if [ -f "$config" ]; then
            files_list="$files_list $(basename "$config")"
            echo "$i. $(basename "$config")"
            i=$((i + 1))
        fi
    done
    set -- $files_list
    read -p "Enter number (1-$(($i - 1))): " selection

    # Validate input: Check if it's a number and within range
    if echo "$selection" | grep -q '^[0-9]\+$' && [ "$selection" -ge 1 ] && [ "$selection" -le $(($i - 1)) ]; then
        config_file="$PROJECT_DIR/${!selection}"
    else
        echo "Invalid selection: Please enter a number between 1 and $(($i - 1)). Exiting."
        exit 1
    fi
}

usage() {
    echo "Usage: $0 [-l] [-f <config-file>] [-i]"
    echo "  -l              List available configuration files and their URLs"
    echo "  -f <config-file> Specify the configuration file to use (default is _config.development.yml)"
    echo "  -i              Select configuration file through interactive menu"
    echo "  -h              Display this help message"
}

# Parse command-line options
while getopts "lf:ih" opt; do
    case "$opt" in
        l)
            list_configs
            exit 0
            ;;
        f)
            config_file="$OPTARG"
            ;;
        i)
            interactive_menu
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Debug output
echo "Script directory: $(get_script_dir)"
echo "Project directory: $PROJECT_DIR"
echo "Config file: $config_file"
echo "Docufy.sh path: $DOCUFY_SH"

# File existence check
if [ ! -f "$config_file" ]; then
    echo "Configuration file not found: $config_file"
    exit 1
fi

if [ ! -f "$DOCUFY_SH" ]; then
    echo "docufy.sh not found at $DOCUFY_SH"
    exit 1
fi

# Start Jekyll with the specified configuration
echo "Starting Jekyll with configuration $config_file ..."
exec bundle exec jekyll clean
exec bundle exec jekyll serve --config _config.yml,"$config_file"
