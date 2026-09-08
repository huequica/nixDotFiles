{ pkgs, ... }:
{
  # NOTE: darwin の場合は証明書の関係で自前で dmg をインストールする必要あり
  # 現状 brew にも cask として登録されてなさそうなので暫定処置
  programs.mousehop.enable = pkgs.stdenv.hostPlatform.isLinux;
}
