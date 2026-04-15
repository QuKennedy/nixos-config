{
    description = "My system configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixCats.url = "github:BirdeeHub/nixCats-nvim";
        claude-code = {
            url = "github:sadjow/claude-code-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # TODO: add the jb in here like that github search result.

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:danth/stylix/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # https://gerg-l.github.io/spicetify-nix/usage.html
        # https://github.com/search?q=lang%3Anix+inputs.nixpkgs.follows+gerg-l&type=code
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";

        hyprlock = {
            url = "github:hyprwm/hyprlock";
            inputs.nixpkgs.follows = "hyprland/nixpkgs";
        };

        hypridle = {
            url = "github:hyprwm/hypridle";
            inputs.nixpkgs.follows = "hyprland/nixpkgs";
        };

        hyprpaper = {
            url = "github:hyprwm/hyprpaper";
            inputs.nixpkgs.follows = "hyprland/nixpkgs";
        };
    };

    outputs =
        {
            self,
            nixpkgs,
            ...
        }@inputs:
        let
            system = "x86_64-linux";
            homeStateVersion = "25.11";
            user = "beeper";
        in
        {
            nixosConfigurations.beepstation = nixpkgs.lib.nixosSystem {
                system = system;
                specialArgs = {
                    inherit inputs user homeStateVersion;
                    stateVersion = "25.11";
                    hostname = "beepstation";
                };
                modules = [
                    ./hosts/beepstation/configuration.nix
                    # https://journix.dev/posts/ricing-linux-has-never-been-easier-nixos-and-stylix/
                    # TODO: maybe do stylix here?
                ];
            };
        };
}
