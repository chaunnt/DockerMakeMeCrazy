# This workflow will do a clean install of node dependencies, build the source code and run tests across different versions of node
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-nodejs-with-github-actions

# HOW TO USE: copy this file and rename to <source root folder>/.github/Nodejs.yml
# Run node v10.x
# Step: install - execute test - post result (include commits name & author) to Slack via BOT Token

name: react-native-android-build-apk
on:
  push:
    branches: [ main ]

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
          cd android
          chmod +x gradlew #grant gradlew permission
          ./gradlew assembleRelease
      - name: Notify slack success
        if: success()
        env:
          SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
        uses: voxmedia/github-action-slack-notify-build@v1
        with:
          channel: team_app_bds_project
          status: TEST SUCCESS for commit name `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
          color: good
      - name: Notify slack fail
        if: failure()
        env:
          SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
        uses: voxmedia/github-action-slack-notify-build@v1
        with:
          channel: team_app_bds_project
          status: TEST FAILED for commit name - `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
          color: danger
