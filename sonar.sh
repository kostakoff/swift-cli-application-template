#!/usr/bin/env bash

#echo "🧪  Test Swift packages..."

echo "🧪  Test Swift packages..."

swift test --enable-code-coverage

echo "🧪  Prepare test covarage report..."
xcrun llvm-cov show -use-color=false -instr-profile=.build/debug/codecov/default.profdata .build/debug/ApplicationTemplatePackageTests.xctest/Contents/MacOS/ApplicationTemplatePackageTests > sonar-coverage.report

echo "🔎  Run sonar scaning..."

curl https://repo1.maven.org/maven2/org/sonarsource/scanner/cli/sonar-scanner-cli/6.1.0.4477/sonar-scanner-cli-6.1.0.4477-macosx-aarch64.zip > ./sonar-scanner-cli-6.1.0.4477-macosx-aarch64.zip
unzip ./sonar-scanner-cli-6.1.0.4477-macosx-aarch64.zip -d . 
./sonar-scanner-6.1.0.4477-macosx-aarch64/bin/sonar-scanner -Dproject.settings=./sonar-project.properties
