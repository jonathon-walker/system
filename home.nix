{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bat
    comma
    curl
    docker-compose
    google-cloud-sdk
    grpcurl
    jq
    kubectl
    kubectx
    kubernetes-helm
    kubetail
    m-cli
    mkcert
    moreutils
    ngrok
    nixfmt
    pstree
    ripgrep
    tmux
    tree
    wget
    yarn
    yq
    zsh-powerlevel10k
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;

    stdlib = ''
      nvm_use() {
        NODE_VERSION="$1"

        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        nvm use "$NODE_VERSION"
      }

      gvm_use() {
        GO_VERSION="$1"

        [ -s "$GVM_DIR/scripts/gvm" ] && source "$GVM_DIR/scripts/gvm"
        gvm use "$GO_VERSION"
      }

      jabba_use() {
        JAVA_VERSION="$1"

        [ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh"
        jabba use "$JAVA_VERSION"
      }
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;

    shellAliases = {
      k = "kubectl";
      cd-dart = "cd $HOME/go/src/lab.identitii.com/identitii";
      cd-dev = "cd $HOME/dev";
      cd-overlay = "cd $HOME/dev/overlay";
      edit-home-nix = "code $HOME/.config/nixpkgs/home.nix";
      rg = "rg --hidden";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-go
      vim-gitgutter
      vim-airline
      nerdtree
    ];
  };

  #   # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  #   # Direnv, load and unload environment variables depending on the current directory.
  #   # https://direnv.net
  #   # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  #   programs.direnv.enable = true;
  #   programs.direnv.nix-direnv.enable = true;

  #   # Htop
  #   # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  #   programs.htop.enable = true;
  #   programs.htop.settings.show_program_path = true;

  #   home.packages = with pkgs; [
  #     # Some basics
  #     coreutils
  #     curl
  #     wget

  #     # Dev stuff
  #     # (agda.withPackages (p: [ p.standard-library ]))
  #     google-cloud-sdk
  #     haskellPackages.cabal-install
  #     haskellPackages.hoogle
  #     haskellPackages.hpack
  #     haskellPackages.implicit-hie
  #     haskellPackages.stack
  #     idris2
  #     jq
  #     nodePackages.typescript
  #     nodejs
  #     purescript

  #     # Useful nix related tools
  #     cachix # adding/managing alternative binary caches hosted by Cachix
  #     # comma # run software from without installing it
  #     niv # easy dependency management for nix projects
  #     nodePackages.node2nix

  #   ] ++ lib.optionals stdenv.isDarwin [
  #     cocoapods
  #     m-cli # useful macOS CLI commands
  #   ];

  #   # Misc configuration files --------------------------------------------------------------------{{{

  #   # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  #   home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
  #     templates = {
  #       scm-init = "git";
  #       params = {
  #         author-name = "Your Name"; # config.programs.git.userName;
  #         author-email = "youremail@example.com"; # config.programs.git.userEmail;
  #         github-username = "yourusername";
  #       };
  #     };
  #     nix.enable = true;
  #   };

}
