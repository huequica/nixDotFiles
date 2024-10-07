_:
let
  onePassPath = "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };

  # to fix cannot execute `git push` via jetbrains IDE problem
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };
}
