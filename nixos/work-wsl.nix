{ pkgs, config, lib, certs, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  wsl = {
    docker-desktop.enable = false;

    extraBin = with pkgs; [
        { src = "${coreutils}/bin/mkdir"; }
        { src = "${coreutils}/bin/cat"; }
        { src = "${coreutils}/bin/whoami"; }
        { src = "${coreutils}/bin/ls"; }
        { src = "${busybox}/bin/addgroup"; }
        { src = "${su}/bin/groupadd"; }
        { src = "${su}/bin/usermod"; }
    ];
    # wslConf = {
    #     network.generateResolvConf = false;
    # };
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  # patch the script 
  systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  # wsl-vpnkit service
  systemd.services.wsl-vpnkit = {
      enable = true;
      description = "WSL VPNKit Service";
      after = ["newtwork.target"];
  
      serviceConfig = {
          ExecStart = "${pkgs.wsl-vpnkit}/bin/wsl-vpnkit";
          Restart = "always";
          KillMode = "mixed";
      };
  
  };

  # reduce journald log size
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=100M
  '';


  # ai tools don't have purely free licenses.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "copilot.vim"
    "oracle-instantclient"
    "claude-code"
  ];

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;


  nix.settings.trusted-users = [ "root" "nixos" ];
  users.users.nixos = {
      isNormalUser = true;
      name = "nixos";
      home = "/home/nixos";
      shell = pkgs.zsh;
      extraGroups = [ "docker" ];
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  # kinsale certs
  security.pki.certificates = [
      (builtins.readFile "${certs}/trusted.kmi.lan.pem")
  ];

  # fix java certs
  environment.variables.JAVAX_NET_SSL_TRUSTSTORE = "etc/ssl/certs/ca-certificates.crt";

  # garbage collection
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
  };


  # trying auto-optimise in favor of the scheduled gc
  # nix.optimise.automatic =  true;
  # nix.optimise.dates = ["08:30"];
  nix.settings.auto-optimise-store = true;

  # download settings
  nix.settings.download-attempts = 10;
  nix.settings.stalled-download-timeout = 300;

  time.timeZone = "America/New_York";
}
