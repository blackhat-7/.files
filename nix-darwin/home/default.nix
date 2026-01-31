{ pkgs, ... }:
{
  imports = [
    ./programs
  ];
  home.stateVersion = "23.11"; # Or your desired version
  # Packages you want for your user
  # nixpkgs.config.allowUnfree = true;
  home.packages = [
    pkgs.neofetch
    # pkgs.colima
    # pkgs.docker
    # pkgs.docker-compose
    pkgs.exiftool
    # pkgs.tailscale
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.opentofu
    # pkgs.terragrunt
    (pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.kubectl pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
    pkgs.golangci-lint
    # pkgs.ollama
    pkgs.nightlight
    pkgs.nodejs_24
    pkgs.spotify
    # (pkgs.spotify.overrideAttrs (oldAttrs: {
    #   src = pkgs.fetchurl {
    #     url = "https://web.archive.org/web/20251029235406/https://download.scdn.co/SpotifyARM64.dmg";
    #     hash = "sha256-0gwoptqLBJBM0qJQ+dGAZdCD6WXzDJEs0BfOxz7f2nQ=";
    #   };
    # }))
    pkgs.slack
    pkgs.discord
    pkgs.raycast
    pkgs.google-cloud-sql-proxy
    pkgs.dbeaver-bin
    pkgs.gopls
    pkgs.rustup
    pkgs.mongodb-compass
    pkgs.brave
    pkgs.ffmpeg_6-headless
    pkgs.exempi
    pkgs.sqlc
    pkgs.github-copilot-cli
    pkgs.p7zip
    pkgs.vi-mongo
    pkgs.tabiew
    pkgs.just
    pkgs.lazysql
    pkgs.packer
    pkgs.webtorrent_desktop
    pkgs.moonlight-qt
  ];


  launchd.agents.turn-on-night-shift = {
    # 'enable = true' is conventional for Home Manager modules
    enable = true;

    # Use 'config' instead of 'serviceConfig'
    config = {
      ProgramArguments = [
        "${pkgs.nightlight}/bin/nightlight"
        "on"
      ];
      RunAtLoad = true;
    };
  };

  # launchd.agents.ollama = {
  #   enable = true;
  #   config = {
  #     # Unique label for the Ollama service
  #     Label = "com.illusion.ollama";
  #     # Command to start the Ollama server
  #     ProgramArguments = [
  #       "${pkgs.ollama}/bin/ollama"
  #       "serve"
  #     ];
  #     # Start on load and keep alive
  #     RunAtLoad = true;
  #     KeepAlive = true;
  #     # Log standard output and errors
  #     StandardOutPath = "/Users/illusion/Library/Logs/ollama.log";
  #     StandardErrorPath = "/Users/illusion/Library/Logs/ollama.error.log";
  #   };
  # };
}
