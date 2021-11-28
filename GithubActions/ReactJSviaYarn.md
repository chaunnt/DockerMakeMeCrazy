# This workflow will do a clean install of node dependencies, build the source code and run tests across different versions of node
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-nodejs-with-github-actions

# Run node v10.x
# Step: install - execute test - post result (include commits name & author) to Slack via BOT Token

# HOW TO USE: copy this file and rename to <source root folder>/.github/Nodejs.yml

name: NodeJS with Grunt

on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12.22]
    
    steps:
    - uses: actions/checkout@v2

    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v1
      with:
        node-version: ${{ matrix.node-version }}

    - name: Build website
      run: |
        yarn install
        # package.json > "build-pro": "env-cmd -f .env.production react-app-rewired build"
        yarn build-pro
        
    - name: Notify slack success
      if: success()
      env:
        SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
      uses: voxmedia/github-action-slack-notify-build@v1
      with:
        channel: team_web_bds_project
        status: BUILD SUCCESS USERWEB for commit name `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
        color: good
    - name: Notify slack fail
      if: failure()
      env:
        SLACK_BOT_TOKEN: ${{ secrets.SLACK_NOTIFICATIONS_BOT_TOKEN }}
      uses: voxmedia/github-action-slack-notify-build@v1
      with:
        channel: team_web_bds_project
        status: BUILD FAILED USERWEB for commit name - `${{ github.event.head_commit.message }}` from `${{ github.event.head_commit.author.name }}`
        color: danger
