{ pkgs, nix-ld, ... }:
{
  home = {
    packages = with pkgs; [ volta ];
    sessionPath = [ "$HOME/.volta/bin" ];
  };
}
