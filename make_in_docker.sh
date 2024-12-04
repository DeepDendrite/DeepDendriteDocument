#!/bin/bash

# Check if the Docker image 'deepdendritedoc' exists
if ! docker images | grep -q "^deepdendritedoc"; then
    echo "Error: Docker image 'deepdendritedoc' not found. Please build the image first."
    echo "You can build the Docker image by running:"
    echo "docker build -t deepdendritedoc ."
    exit 1
fi

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided. Please specify a make target (e.g., 'html', 'clean')."
    echo "Use '$0 help' to list all the targets."
    echo "Usage: $0 <make-target>"
    exit 1
fi

# Run the Docker container with the provided arguments
docker run -it --rm --user $(id -u):$(id -g) -v $(pwd):/app deepdendritedoc "$@"

