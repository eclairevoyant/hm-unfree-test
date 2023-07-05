{ config, pkgs, pacclean, ... }:

{
  home.username = "userName";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [ _pacclean ];

  #nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (f: p: {
      _pacclean = pacclean.packages.x86_64-linux.default.overrideAttrs
        (_: { meta.license = p.lib.licenses.free; });
    })
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
}
