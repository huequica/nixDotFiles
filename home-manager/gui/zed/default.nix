{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "swift"
      "Biome"
      "Material Icon Theme"
    ];

    userSettings = {
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Dark Purple";
      };
      icon_theme = {
        mode = "system";
        light = "Material Icon Theme";
        dark = "Zed (Default)";
      };
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
    };
  };
}
