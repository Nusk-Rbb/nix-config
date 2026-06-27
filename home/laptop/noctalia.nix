{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "SystemMonitor";
              compactMode = false;
              showCpuTemp = false;
              showDiskUsage = true;
            }
            {
              id = "MediaMini";
              maxWidth = 500;
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              displayMode = "graphic";
              id = "Battery";
            }
            {
              clockColor = "primary";
              customFont = "JetBrainsMono Nerd Font";
              formatHorizontal = "ddd mm/dd HH:mm:ss";
              formatVertical = "HH:mm:ss";
              id = "Clock";
              useCustomFont = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/nusk/.face";
        radiusRatio = 0.2;
      };
      location = {
        name = "Tokyo, Japan";
      };
    };
  };

  home.file.".face".source = ../../images/face.png;
}
