#!/bin/bash

# TODO: タグの名前を変更すること
MESSAGE=`git log --oneline | head -n 1`

echo "ios build..."
flutter build ipa --export-options-plist="ios/ExportOptions.plist"
echo "ios uploading..."
dg deploy build/ios/ipa/routine_app.ipa --message "$MESSAGE"

echo "android build..."
flutter build appbundle
echo "android uploading..."
dg deploy build/app/outputs/bundle/release/app-release.aab --message "$MESSAGE"
