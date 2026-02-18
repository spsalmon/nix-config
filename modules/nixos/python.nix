{ lib, config, pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    (python313.withPackages(ps: with ps; [ numpy matplotlib python-lsp-server pyls-isort python-lsp-ruff python-lsp-black ipykernel jupyter-core]))
    micromamba
  ];

  # Required to make mamba-managed Python run without an FHS environment
  programs.nix-ld.enable = true;

  environment.sessionVariables = {
    # Personal preference, default is ~/.micromamba
    MAMBA_ROOT_PREFIX = "/home/sacha/micromamba";
  };
  programs.fish = {
    interactiveShellInit = ''
      eval "$(micromamba shell hook -s fish)"
    '';
  };
}
