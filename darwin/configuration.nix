{ pkgs, lib, options, ... }: {
  # Nix configuration ------------------------------------------------------------------------------

  nix.binaryCaches = [ "https://cache.nixos.org/" ];
  nix.binaryCachePublicKeys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.trustedUsers = [ "@admin" ];
  users.nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    promptInit =
      "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  environment.variables = { EDITOR = "vim"; };

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ terminal-notifier ];

  # Fonts

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      recursive
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
