{ pkgs, ... }: {

  imports = [
    ./kitty.nix
    ./tmux.nix
    ./fish.nix
  ];

  programs = {
    bash.enable = true;
    # zsh.enable = true;
    fish.enable = true;
    aichat.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    btop.enable = true;
    zoxide.enable = true;
    tmux.enable = true;
    lsd.enable = true;
    jq.enable = true;
    bat.enable = true;
    fzf.enable = true;
    zed-editor.enable = true;
    neovim.enable = true;
  };
}
