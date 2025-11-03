{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza
    git
    fzf
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    # Use Oh My Fish (OMF) plugin manager equivalent
    plugins = [
      # Fast autocompletion framework
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      # Syntax highlighting and prompt theming
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }

      # Set up your theme and prompt appearance here
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
    ];

    shellInit = ''
      # --- Aliases (using Fish's function system) ---

      # General Utility
      alias cls "clear"
      function ls
        eza --long --color=always --icons=always --no-user $argv
      end
      function emptytrash
        rm -rf ~/.local/share/Trash/files/* && rm -rf ~/.local/share/Trash/info/*
      end

      # Nix Commands (converted from Zsh aliases)
      function ns
        sudo nixos-rebuild switch --flake ~/nixos#synthesis
      end
      function hm
        home-manager switch --flake ~/nixos#naminesh@synthesis
      end
      function flakeupdate
        nix flake update ~/nixos
      end

      # --- Starship Prompt ---
      # This ensures Starship is executed when Fish starts
      starship init fish | source
    '';
  };

  programs.starship.enable = true;
}
