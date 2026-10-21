{ pkgs, ... }:
{
  # https://github.com/NixOS/nixpkgs/pull/531687 が merge されるまでの暫定対応
  nixpkgs.overlays = [
    (final: prev: {
      mozc = prev.mozc.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace src/gui/dictionary_tool/dictionary_tool.ui \
            --replace-fail '"::mozc::gui::' '"mozc::gui::' \
            --replace-fail '<class>::mozc::gui::' '<class>mozc::gui::'
        '';
      });
    })
  ];
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;

    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-skk
    ];
  };
}
