{ wdc, pkgs, ... }:
{
  home.packages = [ wdc.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
