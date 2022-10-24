{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  homebrew.enable = true;
  homebrew.autoUpdate = false;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "bufbuild/buf"
    "elastic/tap"
    "goreleaser/tap"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/cask"
    "homebrew/core"
    "homebrew/services"
    "nrlquaker/createzap"
    "TomAnthony/brews"
    "warrensbox/tap"
  ];

  homebrew.masApps = {
    WireGuard = 1451685025;
    "Microsoft Remote Desktop" = 1295203466;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "1password-beta"
    "airtame"
    "amethyst"
    "appcleaner"
    "docker"
    "google-chrome"
    "insomnia"
    "iterm2"
    "pgadmin4"
    "slack"
    "spotify"
    "stats"
    "virtualbox"
    "visual-studio-code"
    "vlc"
    "whatsapp"
    "zoom"
  ];

  ## Fallback to brews if NixOS doesn't provide a binary
  homebrew.brews = [
    "buf"
    "filebeat-full"
    "gnu-sed"
    "goreleaser"
    "itermocil"
    "libxml2"
    "nvm"
    "pkg-config"
    "pnpm"
    "pyenv"
    "tfswitch"
    "tgswitch"
  ];
}
