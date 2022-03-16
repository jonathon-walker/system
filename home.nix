{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bat
    comma
    curl
    delta
    docker-compose
    envsubst
    go
    google-cloud-sdk
    grpcurl
    jq
    kubectl
    kubectx
    kubernetes-helm
    kubetail
    m-cli
    mas
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
    nix-direnv.enable = true;

    stdlib = ''
      nvm_use() {
        NODE_VERSION="$1"

        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        nvm use "$NODE_VERSION"
      }

      gvm_use() {
        GO_VERSION="$1"

        source $HOME/.gvm/scripts/gvm
        gvm use "$GO_VERSION"
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

    initExtraFirst = ''
      source $HOME/.gvm/scripts/gvm
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source $HOME/.p10k.zsh

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

    '';

    initExtra = ''
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    '';
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
}
