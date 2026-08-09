{ pkgs, ... }:
{
  # vlc は darwin 未対応のため mac では homebrew cask を利用する (hosts/huequica-m-darwin/darwin.nix)
  home.packages =
    with pkgs;
    [
      pear-desktop
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ vlc ];
}
