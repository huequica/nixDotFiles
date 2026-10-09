{
  pkgs,
  lib,
  isWSL,
  ...
}:
let
  # パスに空白を含むため ssh の config 上ではクォートが必要
  onePasswordAgentPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"''
    else
      "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      # WSL 上には 1Password の agent.sock が存在しないので指定しない
      IdentityAgent = if isWSL then null else onePasswordAgentPath;
    };
  };

  # WSL では Windows 側の 1Password の agent を使うため ssh.exe に任せる
  programs.git.settings.core.sshCommand = lib.mkIf isWSL "ssh.exe";

  # to fix cannot execute `git push` via jetbrains IDE problem
  # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    # 前回の chmod 400 で書き込み不可になった状態から上書きできるよう、一度削除してから書き直す
    onChange = "rm -f ~/.ssh/config && cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config";
  };
}
