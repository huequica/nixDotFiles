{ username, ... }:
{
  nix-homebrew = {
    enable = true;
    user = username;
    enableRosetta = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

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
      "azookey"
      "zed"
      "microsoft-teams"
    ];
  };
}
