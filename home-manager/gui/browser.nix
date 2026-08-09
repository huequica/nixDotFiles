{ pkgs, ... }:
let
  customVivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
    dontWrapQtApps = false;
    dontPatchELF = true;
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
  });
in
{
  programs = {
    firefox.enable = true;
    google-chrome.enable = true;
  };

  # plasma6 では現状 vivaldi が正しく起動しない問題がある
  # vivaldi は darwin 未対応のため mac では homebrew cask を利用する (hosts/huequica-m-darwin/darwin.nix)
  home.packages = pkgs.lib.optionals pkgs.stdenv.isLinux [
    customVivaldi
  ];
}
