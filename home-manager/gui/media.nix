{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    pear-desktop
  ];
}
