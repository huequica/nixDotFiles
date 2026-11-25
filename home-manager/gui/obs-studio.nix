{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
