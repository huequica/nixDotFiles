{ pkgs, ... }:
{
  home.packages = with pkgs; lib.optionals pkgs.stdenv.hostPlatform.isLinux [ discord ];
}
