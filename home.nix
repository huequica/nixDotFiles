{ pkgs, ... }:
{
  home = rec {
    username = "huequica";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vscode
    pingu
  ];
}
