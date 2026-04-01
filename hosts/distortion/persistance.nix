{ ... }:
{
  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/docker"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
  programs.fuse.userAllowOther = true;
}
