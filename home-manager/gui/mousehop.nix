{ pkgs, ... }:
{
  programs.mousehop = {
    # NOTE: darwin の場合は証明書の関係で自前で dmg をインストールする必要あり
    # 現状 brew にも cask として登録されてなさそうなので暫定処置
    enable = pkgs.stdenv.hostPlatform.isLinux;
    # モジュール側の既定値が非推奨の stdenv.isLinux / isDarwin を参照して警告が出るため明示する
    systemd = pkgs.stdenv.hostPlatform.isLinux;
    launchd = pkgs.stdenv.hostPlatform.isDarwin;
  };
}
