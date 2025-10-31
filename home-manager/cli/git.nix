{
  pkgs,
  lib,
  pkgs-stable,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "huequica";
        email = "dev@huequica.xyz";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzrPOJ5QeoNTLuBc6q6QaX2aZDU7KoHk+vUFhDXMEaT";
      };

      core.editor = "vim";

      gpg.format = "ssh";

      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit.gpgsign = true;
    };
  };

  programs.gh = {
    enable = true;
    package = pkgs-stable.gh;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
      };
    };
  };
}
