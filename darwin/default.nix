{ pkgs, ... }: {
  imports = [ ./configuration.nix ./homebrew.nix ./preferences.nix ];
}
