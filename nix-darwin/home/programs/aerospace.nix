{ pkgs, ... }:
{
  programs.aerospace = {
    enable = true;
    settings =
      let
        sticky-pip-script = pkgs.writeShellScriptBin "sticky-pip" ''
          current_workspace=$(${pkgs.aerospace}/bin/aerospace list-workspaces --focused)
          ${pkgs.aerospace}/bin/aerospace list-windows --all | grep -E "(Picture-in-Picture|Picture in Picture)" | awk '{print $1}' | while read window_id; do
            [ -n "$window_id" ] && ${pkgs.aerospace}/bin/aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
          done
        '';
      in
      {
        on-window-detected = [
          {
            "if" = {
              app-name-regex-substring = "Zen";
              window-title-regex-substring = "Picture-in-Picture";
            };
            run = "layout floating";
          }
        ];
        exec-on-workspace-change = [
          "/bin/bash"
          "-c"
          "${sticky-pip-script}/bin/sticky-pip"
        ];
      }
      // builtins.fromTOML ''
            [mode.main.binding]
            # See: https://nikitabobko.github.io/AeroSpace/commands#layout
            cmd-slash = 'layout tiles horizontal vertical'
            cmd-comma = 'layout accordion horizontal vertical'

            # See: https://nikitabobko.github.io/AeroSpace/commands#focus
            # cmd-h = 'focus left'
            cmd-j = 'focus down'
            cmd-k = 'focus up'
            # cmd-l = 'focus right'

            # See: https://nikitabobko.github.io/AeroSpace/commands#move
            cmd-shift-h = 'move left'
            cmd-shift-j = 'move down'
            cmd-shift-k = 'move up'
            cmd-shift-l = 'move right'

            # See: https://nikitabobko.github.io/AeroSpace/commands#resize
            alt-minus = 'resize smart -50'
            alt-equal = 'resize smart +50'

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
            cmd-1 = 'workspace 1'
            cmd-2 = 'workspace 2'
            cmd-3 = 'workspace 3'
            cmd-4 = 'workspace 4'
            cmd-5 = 'workspace 5'
            cmd-6 = 'workspace 6'
            cmd-7 = 'workspace 7'
            cmd-8 = 'workspace 8'
            cmd-9 = 'workspace 9'
            # alt-a = 'workspace A' # In your config, you can drop workspace bindings that you don't need
            # alt-b = 'workspace B'
            # alt-c = 'workspace C'
            # alt-d = 'workspace D'
            # alt-e = 'workspace E'
            # alt-f = 'workspace F'
            # alt-g = 'workspace G'
            # alt-i = 'workspace I'
            # alt-m = 'workspace M'
            # alt-n = 'workspace N'
            # alt-o = 'workspace O'
            # alt-p = 'workspace P'
            # alt-q = 'workspace Q'
            # alt-r = 'workspace R'
            # alt-s = 'workspace S'
            # alt-t = 'workspace T'
            # alt-u = 'workspace U'
            # alt-v = 'workspace V'
            # alt-w = 'workspace W'
            # alt-x = 'workspace X'
            # alt-y = 'workspace Y'
            # alt-z = 'workspace Z'

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
            cmd-shift-1 = 'move-node-to-workspace 1'
            cmd-shift-2 = 'move-node-to-workspace 2'
            cmd-shift-3 = 'move-node-to-workspace 3'
            cmd-shift-4 = 'move-node-to-workspace 4'
            cmd-shift-5 = 'move-node-to-workspace 5'
            cmd-shift-6 = 'move-node-to-workspace 6'
            cmd-shift-7 = 'move-node-to-workspace 7'
            cmd-shift-8 = 'move-node-to-workspace 8'
            cmd-shift-9 = 'move-node-to-workspace 9'
            # alt-shift-a = 'move-node-to-workspace A'
            # alt-shift-b = 'move-node-to-workspace B'
            # alt-shift-c = 'move-node-to-workspace C'
            # alt-shift-d = 'move-node-to-workspace D'
            # alt-shift-e = 'move-node-to-workspace E'
            # alt-shift-f = 'move-node-to-workspace F'
            # alt-shift-g = 'move-node-to-workspace G'
            # alt-shift-i = 'move-node-to-workspace I'
            # alt-shift-m = 'move-node-to-workspace M'
            # alt-shift-n = 'move-node-to-workspace N'
            # alt-shift-o = 'move-node-to-workspace O'
            # alt-shift-p = 'move-node-to-workspace P'
            # alt-shift-q = 'move-node-to-workspace Q'
            # alt-shift-r = 'move-node-to-workspace R'
            # alt-shift-s = 'move-node-to-workspace S'
            # alt-shift-t = 'move-node-to-workspace T'
            # alt-shift-u = 'move-node-to-workspace U'
            # alt-shift-v = 'move-node-to-workspace V'
            # alt-shift-w = 'move-node-to-workspace W'
            # alt-shift-x = 'move-node-to-workspace X'
            # alt-shift-y = 'move-node-to-workspace Y'
            # alt-shift-z = 'move-node-to-workspace Z'

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
            # alt-tab = 'workspace-back-and-forth'
            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            # alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

            # See: https://nikitabobko.github.io/AeroSpace/commands#mode
            alt-shift-semicolon = 'mode service'

        # 'service' binding mode declaration.
        # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
        [mode.service.binding]
            esc = ['reload-config', 'mode main']
            r = ['flatten-workspace-tree', 'mode main'] # reset layout
            f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout
            backspace = ['close-all-windows-but-current', 'mode main']

            # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
            #s = ['layout sticky tiling', 'mode main']

            alt-shift-h = ['join-with left', 'mode main']
            alt-shift-j = ['join-with down', 'mode main']
            alt-shift-k = ['join-with up', 'mode main']
            alt-shift-l = ['join-with right', 'mode main']

            down = 'volume down'
            up = 'volume up'
            shift-down = ['volume set 0', 'mode main']
      '';
  };
}
