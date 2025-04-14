#!/usr/bin/env bash

#echo "📦  Updating Swift packages..."
#swift package update

echo "📦  Determining new version..."
VERSION="$(cat ./version)"

echo "📦  Updating compiled version to $VERSION..."
cat ./Sources/ApplicationTemplate/ApplicationTemplate.swift | \
    awk -v version="$VERSION" '/version: "master"/ { printf "version: \"%s\"\n", version; next } 1' > .tmp && \
    mv .tmp ./Sources/ApplicationTemplate/ApplicationTemplate.swift;

echo "📦  Building..."
swift build -c release --static-swift-stdlib

echo "📦  Test release build..."
.build/release/swift-application --version

echo "📦  Creating package..."
EXEC_NAME="swift-application"
PACKAGE_NAME="swift-application-$VERSION"
mkdir -p ./$PACKAGE_NAME

README="./$PACKAGE_NAME/README.txt"

echo "Manual Install Instructions for ApplicationTemplate v$VERSION" > $README
echo "" >> $README
echo "- Move executable $EXEC_NAME into ~/swift-application/" >> $README
echo "- Type '~/swift-application/$EXEC_NAME --help' into terminal to verify installation" >> $README

cp .build/release/swift-application ./$PACKAGE_NAME/$EXEC_NAME

tar -cvzf swift-application-$VERSION.tar.gz ./$PACKAGE_NAME
