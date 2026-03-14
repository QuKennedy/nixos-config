{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
  # TODO: Figure out what should be in this vs in home mgr, i guess this is the packages for the host (system) itself, and then the user (beeper) can have his own packages from home-manager?
    gcc
    python3
    # kdenlive
    # jetbrains.pycharm-professional
    # jre8
    # qemu
    # quickemu
  ];
}
