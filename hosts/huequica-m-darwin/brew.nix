{
  username,
  nix-homebrew,
  ...
}:
{
  nix-homebrew = {
    enable = true;
    user = username;
    enableRosetta = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    # TODO: migrate 完了したタイミングでコメントアウトを外す()
    # onActivation.cleanup = "uninstall";

    brews = [
      "xcodegen"
      "cliclick"
    ];

    casks = [
      "vlc"
      "vivaldi"
      "scroll-reverser"
      "discord"
      "raycast"
      "1password"
    ];
  };
}
