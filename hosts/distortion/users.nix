{
  pkgs,
  ...
}:
{
  users.mutableUsers = false;
  programs.fish.enable = true;
  users.users.spectre = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "docker"
      "input"
      "video"
    ];
    password = "disarray";
    shell = pkgs.fish;
    packages = [ ];
    openssh.authorizedKeys.keys = [
    ];
  };

  environment.persistence."/nix/persist" = {
    users.spectre.directories = [
      "Projects"
      "Documents"
      "Pictures"
    ];
  };
}
