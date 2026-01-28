{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  users.defaultUserShell = pkgs.fish;
}
