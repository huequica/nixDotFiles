{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--dalete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  programs.nix-ld.enable = true;
}
