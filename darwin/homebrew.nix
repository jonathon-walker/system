{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "amethyst"
    "appcleaner"
    "docker"
    "insomnia"
    "iterm2"
    "google-chrome"
    "slack"
    "spotify"
    "virtualbox"
    "visual-studio-code"
    "vlc"
  ];
}
