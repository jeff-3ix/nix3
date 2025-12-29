{
  description = "NixOS configuration";

  inputs = {
    # Main: unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Pinned set: 25.11
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home-manager: track current home-manager, but use the same nixpkgs as the system
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          inherit system;

          # Make pkgsStable available to all modules as an argument
          specialArgs = {
            inherit pkgsStable;
          };
          
          modules = [
            ./hosts/dell/default.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit pkgsStable;
              };
              
              home-manager.users.jeffu = import ./home/jeffu/default.nix;
            }
          ];
        };
      };
    };
}
