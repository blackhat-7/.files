{ pkgs, ...}: {
  programs.kitty = {
    enable = true;
    themeFile = "rose-pine";
    extraConfig = ''
      hide_window_decorations      titlebar-only
      cursor_trail 3

      font_size 14
      font_family      family="MesloLGLDZ Nerd Font"
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
    '';
  };
}
