{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/NUR";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      disko,
      impermanence,
      nur,
      ...
    }:
    let
      user = "dr";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit
            inputs
            disko
            nixpkgs
            nixpkgs-unstable
            impermanence
            user
            nur
            ;
        }
      );
    };
}
