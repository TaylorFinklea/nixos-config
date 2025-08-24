#!/bin/bash

# Switch to work configuration using home-manager
echo "Switching to work configuration..."
home-manager switch --flake .#work

# Execute work-homebrew script
echo "Running work-homebrew setup..."
./home/work/homebrew.sh

echo "Work configuration switch complete!"
