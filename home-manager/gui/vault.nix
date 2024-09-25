{
  nixpkgs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      _1password-gui = prev._1password-gui.override {
        polkitPolicyOwners = [ "huequica" ];
      };
    })
  ];

  home.packages = with pkgs; [
    _1password
    _1password-gui
  ];
}
