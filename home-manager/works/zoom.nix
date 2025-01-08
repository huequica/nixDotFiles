{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # latest zoom-us has problem that failed to launch
    # https://github.com/NixOS/nixpkgs/issues/371488#issuecomment-2575970402
    (zoom-us.overrideAttrs {
      version = "6.2.11.5069";
      src = pkgs.fetchurl {
        url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
        hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
      };
    })
  ];
}
