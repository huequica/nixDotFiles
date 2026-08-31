{ wdc, pkgs, ... }:
{
  home.packages = [ wdc.packages.${pkgs.system}.default ];
}
