{ ... }:
{
  networking.useDHCP = true;
  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      :1337

      handle_path /comfy/* {
          reverse_proxy localhost:7860
      }

      handle_path /chat/* {
          reverse_proxy localhost:7861
      }
    '';
  };
}
