{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  users.users.${config.system.username} = pkgs.fish;
}
