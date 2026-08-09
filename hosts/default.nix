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

  makeDarwinSystem =
    {
      hostname,
      username,
      modules,
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs hostname username;
      };
      modules = modules;
    };

  makeHomeManagerConfiguration =
    {
      system,
      username,
      overlays,
      modules,
    }:
    let
      homeDirectory =
        if inputs.nixpkgs.lib.hasSuffix "darwin" system then "/Users/${username}" else "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      extraSpecialArgs = {
        inherit inputs username;
      };

      modules = modules ++ [
        {
          home = {
            inherit username homeDirectory;
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

    justMonika = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "justMonika";
      username = "huequica";
      modules = [ ./justMonika/nixos.nix ];
    };
    huequica-m = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "huequica-m";
      username = "huequica";
      modules = [ ./huequica-m/nixos.nix ];
    };
  };

  darwin = {
    huequica-m-darwin = makeDarwinSystem {
      hostname = "huequica-m-darwin";
      username = "huequica";
      modules = [ ./huequica-m-darwin/darwin.nix ];
    };
  };

  home-manager = {
    "huequica@choco-nix" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [ ./choco-nix/home-manager.nix ];
    };

    "huequica@justYuri" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [ ./justYuri/home-manager.nix ];
    };

    "huequica@justMonika" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [ ./justMonika/home-manager.nix ];
    };

    "huequica@huequica-m" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [ ./huequica-m/home-manager.nix ];
    };

    "huequica@huequica-m-darwin" = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [ ./huequica-m-darwin/home-manager.nix ];
    };
  };
}
