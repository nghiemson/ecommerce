name: Run tests

on:
push:
branches: [ "master" ]
pull_request:
branches: [ "master" ]

jobs:
build:
runs-on: ubuntu-latest

steps:
- uses: actions/checkout@v3

# Consider passing '--fatal-infos' for slightly stricter analysis.
- name: Analyze project source
run: dart analyze

- name: Run tests
run: flutter test