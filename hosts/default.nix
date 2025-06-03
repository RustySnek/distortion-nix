{
  lib,
  disko,
  impermanence,
  nur,
  nixpkgs-unstable,
  nixpkgs,
  ...
}:
let
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.nvidia.acceptLicense = true;
  };
  pkgs-unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.nvidia.acceptLicense = true;
  };
  unstableOverlay = final: prev: { unstable = pkgs-unstable; };
  unstableModule =
    {
      config,
      pkgs,
      ...
    }:
    {
      nixpkgs.overlays = [ unstableOverlay ];
    };
in
{
  distortion = lib.nixosSystem {
    pkgs = pkgs;
    system = "x86_64-linux";
    specialArgs = { inherit impermanence; };
    modules = [
      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      nur.modules.nixos.default
      unstableModule
      ./distortion
      {
        nixpkgs.overlays = [
          nur.overlay
          unstableOverlay
        ];
      }
    ];
  };
}
