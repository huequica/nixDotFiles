{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    extensions = [
      "nix"
      "toml"
      "swift"
      "biome"
      "dark-purple-theme"
      "material-icon-theme"
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

      show_whitespaces = "all";
      format_on_save = "on";
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
      project_panel = {
        dock = "left";
      };
    };
  };
}
