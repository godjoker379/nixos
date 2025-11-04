{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let 
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.config_symlinks
    outputs.homeManagerModules.zsh
    # outputs.homeManagerModules.fish
    outputs.homeManagerModules.kitty
    outputs.homeManagerModules.stylix
    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowInsecure = true;
    };
  };

  home = {
    username = "naminesh";
    homeDirectory = "/home/naminesh";
  };

  home.packages = with pkgs; [
    unzip
    wl-clipboard
    nautilus
    (flameshot.override {enableWlrSupport = true;})
    grim
    slurp
    bibata-cursors
    nerd-fonts.jetbrains-mono
    btrfs-progs
    kdePackages.kate
    fastfetch
    nitch
    hyprmon
    xfce.thunar
    kdePackages.dolphin
    qbittorrent-enhanced
    ngrok
    python313
    python313Packages.pip
    vesktop
    vlc
    trashy
    pipes
    tenki
    mpvpaper
    google-chrome
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "JetBrainsMono NF";
      size = 11;
    };
  };

  programs.home-manager.enable = true;

  programs.dankMaterialShell.enable = true;

  programs.spicetify = {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblockify
       hidePodcasts
       shuffle 
     ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
   };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
