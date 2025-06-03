{ ... }:
{
  networking.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 1337 ];
  services.caddy = {
    enable = true;
    virtualHosts."http://localhost:1337".extraConfig = ''
      reverse_proxy /comfy/* localhost:7860
      reverse_proxy /chat/* localhost:7861
      handle_path /comfy/* {
          reverse_proxy localhost:7860
      }

      handle_path /chat/* {
          reverse_proxy localhost:7861
      }
    '';
  };
}
