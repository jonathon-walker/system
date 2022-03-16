#! /usr/bin/env bash

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
cd /usr/local/Homebrew
git checkout 3.2.17