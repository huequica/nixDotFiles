{
  description = "NixOS & home-manager configurations for huequica";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = (import ./hosts inputs).nixos;

    homeConfigurations = (import ./hosts inputs).home-manager;
  };
}
