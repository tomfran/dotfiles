#!/bin/bash

# Mac OS settings script

echo "Removing dock hide delay..."
defaults write com.apple.dock autohide-delay -float 0

echo "Speeding up dock hide animation..."
defaults write com.apple.dock autohide-time-modifier -float 0.5

echo "Restarting Dock..."
killall Dock

echo "Mac OS settings applied. Note: Replace Caps Lock with Control manually in System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys."
