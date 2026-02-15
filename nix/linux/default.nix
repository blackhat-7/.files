# Linux system configuration with system-manager
{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Import any other Linux-specific modules here
  ];
  # Set host platform
  nixpkgs.hostPlatform = "x86_64-linux";

  # User configuration - only defining the minimum needed for home-manager
  # users.users.illusion = {
  #   name = "illusion";
  #   home = "/home/illusion";
  #   isNormalUser = true;
  #   group = "illusion";
  # };
  # users.groups.illusion = {};
  systemd.services.userborn.enable = false;

  # Environment configuration
  environment = {
    systemPackages = with pkgs; [
      # Basic tools
      curl
      wget
      vim
      git
      htop
      tmux

      # Shells - install to make available system-wide
      fish
      zsh

      # Other system utilities
      openssh
    ];

    # Add shells to /etc/shells
    etc."shells" = {
      enable = true;
      text = ''
        /usr/bin/bash
        /bin/bash
        /run/system-manager/sw/bin/bash
        /bin/sh
        /usr/bin/git-shell
        /usr/bin/fish
        /bin/fish
        /usr/bin/systemd-home-fallback-shell
        /bin/rbash
        /usr/bin/rbash
        /usr/bin/sh
        ${pkgs.fish}/bin/fish
        ${pkgs.zsh}/bin/zsh
      '';
    };

    # Set environment variables via /etc/environment
    etc."environment" = {
      enable = true;
      text = ''
        # Added by system-manager
        LANG=en_US.UTF-8
        LC_ALL=en_US.UTF-8
        TZ=Asia/Kolkata
        # Add other environment variables here
      '';
    };
  };

  # Setup nix
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Configure OpenSSH via systemd service
  systemd.services = {
    openssh = {
      enable = true;
      description = "OpenSSH server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.openssh}/bin/sshd -D -f /etc/ssh/sshd_config";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        KillMode = "process";
        Restart = "always";
      };
    };
    wakeOnLan = {
      enable = true;
      description = "Wake on lan";
      requires = [ "network.target" ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp5s0 wol g";
        Type = "oneshot";
      };
    };
  };

  # OpenSSH configuration - use separate file to avoid conflicts
  environment.etc."ssh/sshd_config.d/99-system-manager.conf" = {
    enable = true;
    text = ''
      # Settings from system-manager
      PermitRootLogin no
      PasswordAuthentication no
      ChallengeResponseAuthentication no
      UsePAM yes
      PrintMotd no
      AcceptEnv LANG LC_*
      Subsystem sftp ${pkgs.openssh}/libexec/sftp-server
    '';
  };
}
