{ pkgs, ... }:
let
  customVivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
    dontWrapQtApps = false;
    dontPatchELF = false;
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
  });
in
{
  programs = {
    firefox.enable = true;
    google-chrome.enable = true;
  };

  # plasma6 では現状 vivaldi が正しく起動しない問題がある
  home.packages = [
    customVivaldi
  ];
}
