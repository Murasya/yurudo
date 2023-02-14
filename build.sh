#!/bin/bash

echo "ios build..."
flutter build ipa --export-options-plist="ios/ExportOptions.plist"
echo "ios uploading..."
dg deploy build/ios/ipa/routine_app.ipa

echo "android build..."
flutter build appbundle
echo "android uploading..."
dg deploy build/app/outputs/bundle/release/app-release.aab
