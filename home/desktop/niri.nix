{ config, pkgs, ... }:

{
  programs.niri.settings = {
    outputs."HDMI-A-2" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 200.0;
      };
      scale = 1.0;
      position = { x = 0; y = 0; };
    };

    outputs."DP-2" = {
      mode = {
        width = 3840;
        height = 2160;
        refresh = 160.0;
      };
      scale = 1.5;
      position = { x = 1920; y = 0; };
    };

    input = {
      keyboard.xkb = {
        layout = "us";
        options = "ctrl:nocaps";
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    layout = {
      gaps = 8;
      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];
      default-column-width = { proportion = 1.0 / 2.0; };
      focus-ring = {
        width = 1;
        active.color = "#7fc8ff";
      };
    };

    window-rules = [
      matches = [ { app-id = "^dev\\.zed\\.Zed$"; } ];
      draw-border-with-background = false;
    ];

    prefer-no-csd = true;

    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
      { command = [ "fcitx5" "-d" ]; }
      { command = [ "xwayland-satellite" ]; }
      { command = [ "vicinae" "server" ]; }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "ghostty";
      "Mod+W".action = spawn "vivaldi";
      "Mod+Shift+W".action = spawn "google-chrome-stable";
      "Mod+Z".action = spawn "zeditor";
      "Mod+E".action = spawn "dolphin";
      "Mod+Q".action = close-window;
      "Mod+Shift+E".action = quit;
      "Mod+D".action = spawn "vicinae" "toggle";

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      "Mod+Shift+H".action = move-column-to-monitor-left;
      "Mod+Shift+L".action = move-column-to-monitor-right;
      "Mod+Shift+J".action = move-window-down;
      "Mod+Shift+K".action = move-window-up;

      "Mod+Left".action = focus-monitor-left;
      "Mod+Right".action = focus-monitor-right;
      "Mod+Up".action = focus-monitor-up;
      "Mod+Down".action = focus-monitor-down;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      "Print".action.screenshot = {};
      "Mod+Shift+S".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Mod+Ctrl+S".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};
      "Mod+Alt+S".action.screenshot-window = {};

      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "5%+";
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "5%-";

      "Mod+Ctrl+L".action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
      "Mod+P".action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
    };
  };
}
