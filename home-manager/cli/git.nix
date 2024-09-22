{ pkgs, pkgs-stable, ...}:
{
  programs.git = {
    enable = true;
    userName = "huequica";
    userEmail = "dev@huequica.xyz";
  };

  programs.gh = {
    enable = true;
    package = pkgs-stable.gh;
    settings.editor = "vim";
  };
}
