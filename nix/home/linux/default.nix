{ pkgs, lib, ... }:

{
  # Linux-specific packages
  home.packages = with pkgs; [
    firefox
    cowsay
    wine
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.kubectl
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    docker
    just
    jdk21
    github-copilot-cli
    gemini-cli
    dbeaver-bin
    google-cloud-sql-proxy
    geeqie
    discord
    vi-mongo
    vicinae
    wl-clipboard
    mongodb-compass
    deskflow
  ];

  home.activation.noisetorch-caps = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD sudo ${pkgs.libcap}/bin/setcap 'CAP_SYS_RESOURCE=+ep' ${pkgs.noisetorch}/bin/noisetorch || true
  '';

  # Enable the generic Linux target
  targets.genericLinux.enable = true;

  # Linux-specific configurations
  xdg = {
    enable = true;
    # Configure XDG directories if needed
  };

  systemd.user.services.vicinae = {
    Unit = {
      Description = "Vicinae Launcher Server";
      After = [ "default.target" ];
    };

    Service = {
      ExecStart = "${pkgs.vicinae}/bin/vicinae server";
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = { WantedBy = [ "default.target" ]; };
  };
  wayland.windowManager.hyprland.systemd.enable = true;
}
