{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    youtube-music
  ];
}
