{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}

