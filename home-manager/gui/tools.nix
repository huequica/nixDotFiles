{ pkgs, ... }:
{
  home.packages = with pkgs; [
    remmina
    rustdesk
    vscode
    jetbrains-toolbox
  ];
}
