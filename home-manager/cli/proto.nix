{ pkgs, ... }:
{
  home.packages = with pkgs; [
    proto
  ];
}
