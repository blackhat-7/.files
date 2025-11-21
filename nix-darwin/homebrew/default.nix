{ ... }: {
  homebrew = {
    enable = true;
    global.autoUpdate = true;
    casks = [
      "zen"
      "docker"
      "linear-linear"
      "chromium"
      "tigervnc-viewer"
      "krisp"
      "wine-stable"
    ];
  };
}
