{ inputs, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
    ];

    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
