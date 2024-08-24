 { lib, config, pkgs, ... }:
{
  # Activate fish
  programs.fish.enable = true;

  programs.fish.promptInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';                                       

  programs.bash = {
  interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
  ];

  # aliases
  programs.fish.shellAliases = {
    temacs = "tmux new -s 'emacs' -d emacs";
    nix-alien = "nix run 'github:thiagokokada/nix-alien#nix-alien' --";
  };
}
