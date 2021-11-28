# This workflow will do a clean install of node dependencies, build the source code and run tests across different versions of node
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-nodejs-with-github-actions

# HOW TO USE: copy this file and rename to <source root folder>/.github/Nodejs.yml
# Run node v10.x
# Step: install - execute test - post result (include commits name & author) to Slack via BOT Token


name: Node.js CI

on:
  push:
    branches: [ master ]

jobs:
  build:

    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [10.x]
        # See supported Node.js release schedule at https://nodejs.org/en/about/releases/

    steps:
    - uses: actions/checkout@v2
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v2
      with:
        node-version: ${{ matrix.node-version }}
    - run: npm install
    - run: npm run test
    - name: Notify slack success
      if: success()
      env:
        SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
      uses: voxmedia/github-action-slack-notify-build@v1
      with:
        channel: team_backend_bds_project
        status: TEST SUCCESS for commit name `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
        color: good
    - name: Notify slack fail
      if: failure()
      env:
        SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
      uses: voxmedia/github-action-slack-notify-build@v1
      with:
        channel: team_backend_bds_project
        status: TEST FAILED for commit name - `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
        color: danger
