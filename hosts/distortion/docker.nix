{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_25;
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
  };
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;
}
