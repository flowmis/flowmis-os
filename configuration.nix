{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Lokalisierung
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "de_DE.UTF-8/UTF-8" ];

  # Zeitzone
  time.timeZone = "Europe/Berlin";

  # Netzwerkdienste
  networking = {
    networkmanager.enable = true;
  };

  # Bootloader-Konfiguration
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    useOSProber = true;
  };
  boot.kernelParams = [ "console=tty1" ];
  networking.hostName = "nixos"; 

  # Benutzerkonfiguration
  users.users.flowmis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Zugriff auf Netzwerkverwaltung
    packages = with pkgs; [
      brave
      emacs
      qtile
      alacritty
      fish
    ];
  };

  # Auto-Login für flowmis
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "flowmis";
    };
  };

  services.xserver = {
    enable = true;
    layout = "de";
    windowManager.qtile.enable = true;
  };

  # Unfreie Pakete erlauben
  nixpkgs.config.allowUnfree = true;

  # Experimentelle Features aktivieren
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Systemweite Pakete hinzufügen
  environment.systemPackages = with pkgs; [
    networkmanager
    neovim
    vim
    wget
    git
  ];
}
