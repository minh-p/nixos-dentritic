{ config, lib, pkgs, ... }:

{
  flake.modules.nixos.nix-settings = {
    nix.settings.auto-optimise-store = true;
  };
}
