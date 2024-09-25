{
  programs.fish = {
    enable = true;
    shellAliases = {
      "d-c" = "docker compose";
      gdel = "git branch -D";
      nd = "nix develop";
    };
  };
}
