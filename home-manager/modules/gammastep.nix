{
    services.gammastep = {
        enable = true;
        provider = "manual";
        latitude = 40.680779;
        longitude = -73.9750141;
        settings = {
            general.adjustment-method = "wayland";
        };
        temperature = {
            day = 6000;
            night = 3800;
        };
    };
}
