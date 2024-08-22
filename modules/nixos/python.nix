{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python312.withPackages(ps: with ps; [ numpy matplotlib python-lsp-server pyls-isort python-lsp-ruff python-lsp-black ipykernel jupyter-core]))
    micromamba
  ];
}
