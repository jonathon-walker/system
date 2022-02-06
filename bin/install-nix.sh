#! /usr/bin/env bash

NIX_VERSION=2.6.0
NIX_CONF_PATH=$HOME/.config/nix

if command -v nix > /dev/null; then
    echo "nix is already installed on this system."
else
    sh <(curl -L https://releases.nixos.org/nix/nix-$NIX_VERSION/install)
fi

if [[ ! -d $NIX_CONF_PATH ]]; then
    mkdir -p "$NIX_CONF_PATH"
fi

if [[ ! -f $NIX_CONF_PATH/nix.conf ]] || ! grep "experimental-features" < "$NIX_CONF_PATH"; then
    echo "experimental-features = nix-command flakes" | tee -a "$NIX_CONF_PATH"/nix.conf
fi