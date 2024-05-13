#!/bin/sh

# Function to list configuration files and their URLs
list_configs() {
    echo "Available configuration files and their URLs:"
    for config in *.yml *.yaml; do
        if [ -f "$config" ]; then
            # Extract the URL using awk, handling different spacing and ensuring only the URL is captured
            url=$(awk -F': ' '/^url[[:space:]]*:/ {print $2; exit}' "$config" | tr -d '"' | cut -d' ' -f1)
            if [ -z "$url" ]; then
                url="URL not set or malformed in file"
            fi
            echo "$config - URL: $url"
        fi
    done
}

# Function to display an interactive menu to choose configuration file
interactive_menu() {
    echo "Select a configuration file by number:"
    local i=1
    local files=()
    for config in *.yml *.yaml; do
        if [ -f "$config" ]; then
            files+=("$config")
            echo "$i. $config"
            i=$((i + 1))
        fi
    done
    read -p "Enter number (1-${#files[@]}): " selection

    # Validate input: Check if it's a number and within range
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "${#files[@]}" ]; then
        config_file="${files[$((selection - 1))]}"
    else
        echo "Invalid selection: Please enter a number between 1 and ${#files[@]}. Exiting."
        exit 1
    fi
}

usage() {
    echo "Usage: $0 [-l] [-f <config-file>] [-i]"
    echo "  -l, --list     List available configuration files and their URLs"
    echo "  -f, --file     Specify the configuration file to use (default is _config.development.yml)"
    echo "  -i, --interactive  Select configuration file through interactive menu"
    echo "  -h, --help     Display this help message"
}

# Default configuration file
config_file="_config.development.yml"

# Parse command-line options
while getopts ":lf:ih-:" opt; do
    case "${opt}" in
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
        -)
            case "${OPTARG}" in
                list)
                    list_configs
                    exit 0
                    ;;
                file)
                    config_file="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    ;;
                interactive)
                    interactive_menu
                    ;;
                help)
                    usage
                    exit 0
                    ;;
                *)
                    echo "Invalid option: --${OPTARG}" >&2
                    usage
                    exit 1
                    ;;
            esac
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

# File existence check
if [ ! -f "$config_file" ]; then
    echo "Configuration file not found: $config_file"
    exit 1
fi

# Start Jekyll with the specified configuration
echo "Starting Jekyll with configuration $config_file ..."
bundle exec jekyll serve --config _config.yml,$config_file
