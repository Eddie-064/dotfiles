#!/bin/bash

defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 0
# use tap instead of click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
# disable force click to quick look
defaults write .GlobalPreferences com.apple.trackpad.forceClick -int 0
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
defaults write FirstClickThreshold -int 0

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
defaults write .GlobalPreferences com.apple.trackpad.scrolling -float 1.0
defaults write .GlobalPreferences com.apple.trackpad.scaling -float 2.0

defaults write NSGlobalDomain KeyRepeat -int 3
# delay untill key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# 0 maps to "Do Nothing"
# 1 maps to "Change Input Source"
# 2 maps to "Show Emoji & Symbols"
# 3 maps to "Start Dictation (Press 🌐︎ Twice)"
defaults write com.apple.HIToolbox AppleFnUsageType -int 0
# 2 enable keyboard navigation, 0 disable.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# more Gestures on trackpad
defaults write com.apple.dock showAppExposeGestureEnabled -int 1
defaults write showDesktopGestureEnabled -int 1
defaults write showLaunchpadGestureEnabled -int 1
defaults write showMissionControlGestureEnabled -int 1
