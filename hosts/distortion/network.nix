{ ... }:
{
  networking.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 6969 ];
  services.caddy = {
    enable = true;
    virtualHosts."http://localhost:6969".extraConfig = ''
      handle_path /comfy {
          reverse_proxy localhost:7860
      }

      redir /chat /chat/
      handle_path /chat/ {
          reverse_proxy localhost:7861
      }


      reverse_proxy localhost:7861
    '';
  };
}
