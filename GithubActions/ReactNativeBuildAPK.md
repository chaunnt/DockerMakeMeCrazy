# This workflow will do a clean install of node dependencies, build the source code and run tests across different versions of node
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-nodejs-with-github-actions

# HOW TO USE: copy this file and rename to <source root folder>/.github/Nodejs.yml
# Run node v10.x
# Step: install - execute test - post result (include commits name & author) to Slack via BOT Token

name: react-native-android-build-apk
on:
  push:
    branches:
      - develop
      - 'releases/**'
    tags:        
      - v3.*
jobs:
  build-android:
    runs-on: ubuntu-latest
    steps: 
      - uses: actions/checkout@v2
      - name: Install npm dependencies using yarn
        run: |
          yarn install
      - name: Build Android Release
        run: |
          cd android && ./gradlew assembleRelease
        # delete old artifacts to save money
      - name: Remove artifacts
        uses: c-hive/gha-remove-artifacts@v1.2.0
        with: 
          # Keep the specified number of artifacts even if they are older than the age.
          skip-recent: 2
          age: '2 day'
      - name: Upload Artifact
        uses: actions/upload-artifact@v1
        with:
          name: app-release.apk
          path: android/app/build/outputs/apk/release/
