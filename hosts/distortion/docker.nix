{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    nvidia-container-toolkit
    docker
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--runtime=nvidia";
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
