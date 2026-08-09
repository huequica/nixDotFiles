{ pkgs, ... }:
let
  # パスに空白を含むため ssh の config 上ではクォートが必要
  onePasswordAgentPath =
    if pkgs.stdenv.isDarwin then
      ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"''
    else
      "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      IdentityAgent = onePasswordAgentPath;
    };
  };

  # to fix cannot execute `git push` via jetbrains IDE problem
  # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    # 前回の chmod 400 で書き込み不可になった状態から上書きできるよう、一度削除してから書き直す
    onChange = "rm -f ~/.ssh/config && cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config";
  };
}
