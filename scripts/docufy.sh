#!/bin/sh

# Print usage information
print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c, --clean       Clean the project directory"
    echo "  -b, --build       Build the Jekyll site"
    echo "  -s, --serve       Serve the Jekyll site locally"
    echo "  -d, --deploy      Deploy the Jekyll site"
    echo "  -p, --publish     Publish the Jekyll site"
    echo "  -t, --test        Test the Jekyll site"
    echo "  --verbose         Enable verbose output"
    echo "  --debug           Enable debug output"
    echo "  -h, --help        Display this help message"
}

# Default options
VERBOSE=false
DEBUG=false

# Handle command line options
while [ $# -gt 0 ]; do
    case "$1" in
        -c|--clean)
            CLEAN=true
            ;;
        -b|--build)
            BUILD=true
            ;;
        -s|--serve)
            SERVE=true
            ;;
        -d|--deploy)
            DEPLOY=true
            ;;
        -p|--publish)
            PUBLISH=true
            ;;
        -t|--test)
            TEST=true
            ;;
        --verbose)
            VERBOSE=true
            ;;
        --debug)
            DEBUG=true
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            print_usage
            exit 1
            ;;
    esac
    shift
done

# Execute the selected actions
if [ "$CLEAN" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Cleaning the project directory..."
    fi
    rm -rf _site
    rm -rf vendor
    rm -rf .jekyll-cache
    rm -rf .jekyll-metadata
fi

if [ "$BUILD" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Building the Jekyll site..."
    fi
    bundle install --path vendor/bundle
    bundle exec jekyll build
fi

if [ "$SERVE" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Serving the Jekyll site locally..."
    fi
    bundle install --path vendor/bundle
    bundle exec jekyll serve --trace --unpublished --livereload --watch --disable-disk-cache
fi

if [ "$DEPLOY" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Deploying the Jekyll site..."
    fi
    # Add deployment commands here
fi

if [ "$PUBLISH" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Publishing the Jekyll site..."
    fi
    # Add publishing commands here
fi

if [ "$TEST" = "true" ]; then
    if [ "$VERBOSE" = "true" ]; then
        echo "Testing the Jekyll site..."
    fi
    # Add testing commands here
fi

if [ "$DEBUG" = "true" ]; then
    echo "Debug mode enabled."
    set -x  # Enable debug mode
fi

exit 0
