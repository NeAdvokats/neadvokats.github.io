# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;    
  };

  
  services.zapret = {
    enable = true;

    udpSupport = true;
  
    udpPorts = [ "443" "50000:65535" ]; 
    params = [
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=2"
      "--dpi-desync-repeats=6"
      "--dpi-desync-fooling=md5sig"
    ];
    whitelist = [
      "discord.com"
      "discordapp.com"
      "discordapp.net"
      "discord.gg"
      "cdn.discordapp.com"
      "media.discordapp.net"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "discord.media"
      "discord.new"
      "discord.gift"
      "discordstatus.com"
      "gateway.discord.gg"
      "discord.co"
      "discord.design"
      "discord.dev"
      ];
    };


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;  

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Ulyanovsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."neadvokats" = {
    isNormalUser = true;
    description = "neadvokats";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  
  #hardware.graphics.enable = true;
  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  open = false;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};

  services.greetd = {
    enable = true;
    settings = {
        default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-user-session --cmd start-hyprland";
        user = "greeter";
      };
    };
  };
  
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
  
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  
  #boot.extraModulePackages = with config.boot.kernelPackages; [ 
  #  amneziawg 
  #];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  
  # networking.wg-quick.interfaces = {
    # awg0 = {
      # type = "amneziawg"; 
      # configFile = "/etc/amnezia/amneziawg/awg0.conf";
      # autostart = true;
    # };
  # };
  
  environment.systemPackages = with pkgs; [
     wget
     fastfetch
     hyprland
     firefox
     kitty 
     waybar
     swaybg
     mako
     rofi
     micro
     bibata-cursors
     git
     # amneziawg-tools
     hyprshot
     vesktop
  ];

  fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.11"; # Did you read the comment? da bratan
}
