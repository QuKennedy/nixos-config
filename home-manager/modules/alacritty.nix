{ lib, ... }:
{
    programs.alacritty = {
        enable = true;
        settings = {
            window.opacity = 1.0;
            window.padding = {
                x = 8;
                y = 8;
            };

            font = {
                # defined in stylix
                # size = 18;
                builtin_box_drawing = true;
                normal = {
                    style = lib.mkForce "Bold";
                };
            };
        };
    };
}
