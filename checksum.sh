#!/bin/sh -

XC_FRAMEWORK_ZIP_PATH="Framework/Product/OpenMultitouchSupportXCF.xcframework.zip"
if [ -e $XC_FRAMEWORK_ZIP_PATH ]; then
  CHECKSUM=$(swift package compute-checksum $XC_FRAMEWORK_ZIP_PATH)
  echo "Checksum: ${CHECKSUM}"
else
  echo "XCFramework.zip is not exist."
fi
