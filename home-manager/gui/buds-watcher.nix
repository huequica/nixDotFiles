{ buds-watcher, pkgs, ... }:
{
  home.packages = [ buds-watcher.packages.${pkgs.system}.default ];
}
