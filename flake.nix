{
  description = "TEST";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pacclean = {
      url = "github:eclairevoyant/pacclean";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, pacclean, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      homeConfigurations.userName = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pacclean; };
        modules = [ ./home.nix ];
      };
    };
}
