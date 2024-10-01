let
  functionsDirectory = ".config/fish/functions";
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      "d-c" = "docker compose";
      gdel = "git branch -D";
      nd = "nix develop";
    };

    loginShellInit = ''
      # volta setup code
      set -gx VOLTA_HOME "$HOME/.volta"
      set -gx PATH "$VOLTA_HOME/bin" $PATH
    '';
  };

  home.file = {
    gsd = {
      source = ./fishs/gsd.fish;
      target = "${functionsDirectory}/gsd.fish";
    };
  };
}
