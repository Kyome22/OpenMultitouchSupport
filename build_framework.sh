#!/bin/sh -
# xcodebuild -version

xcodebuild build \
  -project "Framework/OpenMultitouchSupport.xcodeproj" \
  -scheme "OpenMultitouchSupport" \
  -destination "generic/platform=macOS" \
  -configuration Release \
  -derivedDataPath "Framework/build"

FRAMEWORK_PATH="Framework/build/Build/Products/Release/OpenMultitouchSupport.framework"
lipo -archs ${FRAMEWORK_PATH}/OpenMultitouchSupport

XC_FRAMEWORK_PATH="Framework/Product/OpenMultitouchSupport.xcframework"
if [ -e $XC_FRAMEWORK_PATH ]; then
  rm -rf $XC_FRAMEWORK_PATH
fi
xcodebuild -create-xcframework \
  -framework $FRAMEWORK_PATH \
  -output $XC_FRAMEWORK_PATH
