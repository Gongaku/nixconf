{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "console=tty50,115200"
    "console=tty1"
  ];

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3389 ]; # Enable for xRDP
      allowedUDPPorts = [ 3389 ]; # Enable for xRDP
    };
  }; 

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = { # Enable Keymapping
      layout = "us";
      variant = "";
    };
  };
  services.displayManager.gdm = {
    enable = true;
    autoSuspend = false;
  };
  services.desktopManager.gnome.enable = true;

  # Enable RDP
  services.gnome.gnome-remote-desktop.enable = true;
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
    openFirewall = true;
  };
  
  # Allow laptop to keep running while lid is closed
  services.logind.lidSwitch = "ignore";

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.zsh = {
    enable = true;
  };

  users.users.gongaku = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "gongaku";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gongaku";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   git
   vim
   wget
   tmux
   nettools
   gnome-remote-desktop
   xrdp
   gnome-session
  ];
  environment.variables.EDITOR = "vim";

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
    openFirewall = true; 
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  system.stateVersion = "25.11";
  home-manager.users.gongaku = { pkgs, ... }: {
    home.packages = [ ];
    home.stateVersion = "22.11";
  };
}
