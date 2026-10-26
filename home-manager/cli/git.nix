{
  pkgs,
  lib,
  isWSL,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "huequica";
        email = "dev@huequica.xyz";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF94kAj0VX+nU9O01JQri5aZ1XMGb5QmehH57xUSHhsY";
      };

      core.editor = "vim";

      gpg.format = "ssh";

      "gpg \"ssh\"" = {
        program =
          if isWSL then
            "/mnt/c/Users/huequica/AppData/Local/Microsoft/WindowsApps/op-ssh-sign.exe"
          else
            "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit.gpgsign = true;
    };
  };

  programs.gh = {
    enable = true;
    package = pkgs.gh;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
      };
    };
  };
}
