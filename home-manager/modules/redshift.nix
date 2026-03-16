{
services.redshift = {
  enable = true;
  
  # Display temperature settings (in Kelvin)
  temperature = {
    day = 5500;
    night = 3500;
  };
  
  # Schedule settings
  dawnTime = "6:00-7:45";
  duskTime = "18:35-20:15";
  
  # Brightness
  brightness = {
    day = "1";
    night = "0.8";
  };
  
  extraOptions = [
    "-v"
    "-m randr"
  ];
  
  # Tray Icon
  tray = false;

};
}
