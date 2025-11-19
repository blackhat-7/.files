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

  # Optional: Configure systemd user services if needed
  systemd.user = {
    # Example of a systemd user service (uncomment and customize as needed)
    # services.example-service = {
    #   Unit = {
    #     Description = "Example User Service";
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.hello}/bin/hello";
    #     Restart = "on-failure";
    #   };
    #   Install = {
    #     WantedBy = [ "default.target" ];
    #   };
    # };
  };
}
