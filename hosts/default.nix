{
  lib,
  disko,
  impermanence,
  nur,
  nixpkgs-unstable,
  ...
}:
let
  unstableOverlay = final: prev: {
    unstable = nixpkgs-unstable.legacyPackages.${prev.system};
  };
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
    system = "x86_64-linux";
    specialArgs = { inherit impermanence; };
    modules = [
      {
        nixpkgs.config.allowUnfreePredicate = _: true;
      }
      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      nur.nixosModules.nur
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
