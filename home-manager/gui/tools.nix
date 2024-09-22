{ pkgs, ... }:
{
  home.packages = with pkgs; [
    remmina
    vscode
    jetbrains-toolbox
  ];
}
