{ buds-watcher, pkgs, ... }:
{
  home.packages = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    buds-watcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
