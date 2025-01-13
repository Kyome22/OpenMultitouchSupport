#!/bin/sh -
# xcodebuild -version

xcodebuild build \
  -project "Framework/OpenMultitouchSupportXCF.xcodeproj" \
  -scheme "OpenMultitouchSupportXCF" \
  -destination "generic/platform=macOS" \
  -configuration Release \
  -derivedDataPath "Framework/build"

FRAMEWORK_PATH="Framework/build/Build/Products/Release/OpenMultitouchSupportXCF.framework"
lipo -archs ${FRAMEWORK_PATH}/OpenMultitouchSupportXCF

XC_FRAMEWORK_PATH="OpenMultitouchSupportXCF.xcframework"
if [ -e $XC_FRAMEWORK_PATH ]; then
  rm -rf $XC_FRAMEWORK_PATH
fi
xcodebuild -create-xcframework \
  -framework $FRAMEWORK_PATH \
  -output $XC_FRAMEWORK_PATH

XC_FRAMEWORK_ZIP_PATH="${XC_FRAMEWORK_PATH}.zip"
if [ -e $XC_FRAMEWORK_ZIP_PATH ]; then
  rm -rf $XC_FRAMEWORK_ZIP_PATH
fi

zip -Xyr $XC_FRAMEWORK_ZIP_PATH $XC_FRAMEWORK_PATH
ls -Slh $XC_FRAMEWORK_ZIP_PATH | awk '{print $5, $9}'
rm -rf $XC_FRAMEWORK_PATH

CHECKSUM=$(swift package compute-checksum $XC_FRAMEWORK_ZIP_PATH)
echo "Checksum: ${CHECKSUM}"
