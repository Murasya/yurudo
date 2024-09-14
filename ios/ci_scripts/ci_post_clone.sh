#!/bin/zsh

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
cd ios && pod install # run `pod install` in the `ios` directory.
cd ..

# make secret files
echo ${env_file} > assets/env/dev.json
echo ${firebase_app_id_file} > ios/config/${flavor}/firebase_app_id_file.json
echo ${GoogleService_Info} > ios/config/${flavor}/GoogleService-Info.plist
echo ${firebase_options} > lib/firebase_options.dart

flutter build ios --config-only --flavor ${flavor}

exit 0