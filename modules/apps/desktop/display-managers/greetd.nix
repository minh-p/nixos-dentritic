{
  flake.modules.nixos.greetd = {config, pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings.default_session = {
        user = "greeter";
	command = ''${pkgs.tuigreet}/bin/tuigreet \
	  --cmd ${config.programs.niri.package}/bin/niri-session
	'';
      };
    };
  };
}
