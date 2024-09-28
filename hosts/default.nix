inputs:
let
  makeNixosSystem =
    {
      system,
      hostname,
      username,
      modules,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs hostname username;
      };
    };

  makeHomeManagerConfiguration =
    {
      system,
      username,
      overlays,
      modules,
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      extraSpecialArgs = {
        inherit inputs username;
        pkgs-stable = import inputs.nixpkgs-stable {
          inherit system overlays;
          config.allowUnfree = true;
        };
      };

      modules = modules ++ [
        {
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "22.11";
          };
          programs.home-manager.enable = true;
        }
      ];
    };
in
{
  nixos = {
    choco-nix = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "choco-nix";
      username = "huequica";
      modules = [ ./choco-nix/nixos.nix ];
    };

    justYuri = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "justYuri";
      username = "huequica";
      modules = [ ./justYuri/nixos.nix ];
    };

    huequica-w = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "huequica-w";
      username = "huequica";
      modules = [ ./huequica-w/nixos.nix ];
    };
  };

  home-manager = {
    "huequica@choco-nix" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [ inputs.fenix.overlays.default ];
      modules = [ ./choco-nix/home-manager.nix ];
    };

    "huequica@justYuri" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [ inputs.fenix.overlays.default ];
      modules = [ ./justYuri/home-manager.nix ];
    };

    "huequica@huequica-w" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [ inputs.fenix.overlays.default ];
      modules = [ ./huequica-w/home-manager.nix ];
    };
  };
}
