{ pkgs, lib, ... }:
{
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/works
  ];

  # pkgs-stable (nixpkgs-stable = nixos-23.11) は EOL で aarch64-darwin 向けのバイナリキャッシュがほぼ残っておらず、
  # gh のビルドのために darwin のブートストラップ toolchain (llvm 等) をソースから全部ビルドしてしまうため上書きする
  programs.gh.package = lib.mkForce pkgs.gh;

  # sudo は自身の secure_path しか見ないため `sudo darwin-rebuild` は PATH 解決できない。
  # sudo 込みで関数化することで、履歴呼び出しやコピペでも常に絶対パスで実行されるようにする
  programs.fish.functions = {
    darwin-rebuild = "sudo /run/current-system/sw/bin/darwin-rebuild $argv";
    darwin-version = "/run/current-system/sw/bin/darwin-version $argv";
  };
}
