{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    nvidia-container-toolkit
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    features = {
      cdi = true;
    };
  };
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
  };
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;
}
