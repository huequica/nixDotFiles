{ inputs, pkgs, ... }:
{
  nix.settings = {
    extra-substituters = [
      "https://mousehop.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "mousehop.cachix.org-1:5wbRclpnaMFh5hRLx4BR+UMSkOfCiR2kfr6WLItDpPU="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "root"
      "@wheel"
    ]
    ++ inputs.nixpkgs.lib.optional pkgs.stdenv.hostPlatform.isDarwin "@admin";
  };
}
