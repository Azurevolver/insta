#!/bin/bash
set -e
xcodebuild -project 'Insta.xcodeproj' -scheme 'Insta' -destination 'platform=iOS Simulator,name=iPhone 12' test
