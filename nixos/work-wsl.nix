{ pkgs, config, lib, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
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
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  # patch the script 
  systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  # copilot doesn't have purely free license.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "copilot.vim"
  ];

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  users.users.nixos = {
      isNormalUser = true;
      name = "nixos";
      home = "/home/nixos";
      shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
  ];
}
