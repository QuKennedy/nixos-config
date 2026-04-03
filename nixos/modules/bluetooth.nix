{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    Policy.AutoEnable = true;
    General = {
      FastConnectable = true;
      ReconnectAttempts = 7;
      ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
    };
  };

  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';
}
