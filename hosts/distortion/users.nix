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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKg6aV5JQVmvOJpXNa2ZC45qm/kLixQkGkxC7Qm5NB5M rustysnek@chunchumaru"
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
