{ pkgs, ... }:
{
  # remmina は darwin 未対応のため mac では導入しない
  home.packages =
    with pkgs;
    [
      vscode
      jetbrains-toolbox
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ remmina ];
}
