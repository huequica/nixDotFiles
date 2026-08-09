{ pkgs, ... }:
{
  home.file = {
    ".config/discord/settings.json".text = builtins.readFile ./settings.json;
  };

  home.packages =
    with pkgs;
    [
      # currently, official discord package has cannot use krisp problem
      # vesktop is fixed this problem
      vesktop
    ]
    # for macOS, use homebrew cask
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ discord ];
}
