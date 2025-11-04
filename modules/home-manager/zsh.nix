{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza
    zoxide
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = ["zoxide" "git" "z" "sudo" "colored-man-pages"];
    };

    initContent = ''

      HISTSIZE=50000
      SAVEHIST=10000
      setopt histignoredups sharehistory



      alias ns="sudo nixos-rebuild switch --flake ~/nixos#synthesis"
      alias hm="home-manager switch --flake ~/nixos#naminesh@synthesis"
      alias flakeupdate="nix flake update ~/nixos"

      alias cls="clear"

      alias ls="eza --long --color=always --icons=always --no-user"
      # A slightly better 'ls -a' alternative
      alias lla="eza --long --all --color=always --icons=always --no-user"


      alias emptytrash="trash empty --all"
      alias trashl="trash list"


      # Better TAB completion (already solid)
      zstyle ':completion:*' menu select
      setopt AUTO_MENU
      setopt CORRECT
      setopt GLOB_COMPLETE
    '';
  };

  programs.starship.enable = true;
}
