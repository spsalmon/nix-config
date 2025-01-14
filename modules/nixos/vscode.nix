{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #vscode

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-python.python
        ms-vscode-remote.remote-ssh
        ms-toolsai.jupyter
        mkhl.direnv
      ];
    })
  ];
}
