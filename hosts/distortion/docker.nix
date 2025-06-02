{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    nvidia-container-toolkit
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_25;
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
  };
}
