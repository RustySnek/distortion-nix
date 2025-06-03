{
  pkgs,
  ...
}:
{
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "virtio_blk"
    "virtio_pci"
    "sr_mod"
  ];
  boot.kernelModules = [
    "kvm-amd"
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.initrd.kernelModules = [
    "nvme"
    "dm-snapshot"
    "i2c-dev"
    "i2c-piix4"
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
  ];
  boot.initrd.checkJournalingFS = false;
  services.libinput.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
  };
  services.xserver = {
    videoDrivers = [
      "nvidia"
    ];
    enable = false;
    xkb.layout = "us";
  };
  boot.blacklistedKernelModules = [ ];
  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia-container-toolkit.suppressNvidiaDriverAssertion = true;

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
