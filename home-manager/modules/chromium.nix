{ pkgs, ... }:
{
    programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
            # Vimium
            { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }

            # Return YouTube Dislike
            { id = "gebbhagfogifgggkldgodflihgfeippi"; }

            # LastPass
            { id = "hdokiejnpimakedhajhdlcegeplioahd"; }

            # Hover Zoom+
            { id = "pccckmaobkjjboncdfnnofkonhgpceea"; }

            # Video Speed Controller
            { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; }
        ];
    };
}
