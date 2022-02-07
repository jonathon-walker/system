# system
Declarative system configurations using nix-darwin and home-manager. Only works on MacOS right now.

## Prerequisites
Git needs to be installed (to clone this repo onto the target machine).

## How to use
```bash
# Pull the repo down and cd into it.
git clone https://github.com/jonathon-walker/system ~/.nixpkgs
cd ~/.nixpkgs

# Installs nix and homebrew on the machine.
./bin/install-nix.sh
./bin/install-homebrew.sh

# Build nix-darwin
nix build .#darwinConfigurations.Jonathons-MacBook-Pro.system

# Bootstrap
./result/sw/bin/darwin-rebuild switch --flake .
```

## Troubleshooting

### Chrome doesn't install properly when running darwin-rebuild
Chrome might have been installed outside of Nix. Uninstall it and rebuild the configuration so that Nix manages it.

## Todo
- Get home-manager to manage dotfiles directory
- Make `bin/install-nix.sh` pass the checks here (https://github.com/LnL7/nix-darwin/blob/master/modules/system/checks.nix)
- Figure out how to manage secrets