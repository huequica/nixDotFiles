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
    firefox = {
      enable = true;
      # 既定値が stateVersion 依存で警告が出るため明示する
      configPath = pkgs.lib.mkIf pkgs.stdenv.hostPlatform.isLinux ".mozilla/firefox";
    };
    google-chrome.enable = true;
  };

  # plasma6 では現状 vivaldi が正しく起動しない問題がある
  # vivaldi は darwin 未対応のため mac では homebrew cask を利用する (hosts/huequica-m-darwin/darwin.nix)
  home.packages = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    customVivaldi
  ];
}
