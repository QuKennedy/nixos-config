{ inputs, user, homeStateVersion, ... }: {
  imports = [ inputs.home-manager.nixosModules.default ];
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs homeStateVersion user; };
    users.${user} = import ../../home-manager/home.nix;
  };
}
