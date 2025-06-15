{
  pkgs,
  ...
}:
{
  imports = [
    ./gpg.nix
    ./disk.nix
    ./audio.nix
    ./users.nix
    ./docker.nix
    ./gpg.nix
    ./persistance.nix
    ./network.nix
    ./boot.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      ChallengeResponseAuthentication = false;
    };
  };

  services.passSecretService.enable = true;
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    enableTCPIP = true;
    settings.port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''

      #...
           local all       all     trust
         #type database DBuser origin-address auth-method
         # ipv4
         host  all      all     127.0.0.1/32   trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
  };
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  time.timeZone = "Europe/Warsaw";
  environment.systemPackages = with pkgs; [
    git
    python310Packages.pip
    (python310Packages.pandas.overridePythonAttrs (old: {
      doCheck = false;
    }))
    (python310Packages.numpy.overridePythonAttrs (old: {
      doCheck = false;
    }))
    python310Full
    unstable.devenv
    unstable.neovim
    glib
    man-pages-posix
    ffmpeg
    tts
    whisperx
    wget
    yt-dlp
  ];

  services.dbus.enable = true;
  security.polkit.enable = true;
  nix.settings.trusted-users = [
    "spectre"
    "root"
  ];
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org"
    "https://devenv.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostName = "distortion";
  system.stateVersion = "25.05";
}
