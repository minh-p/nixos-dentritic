{
  flake.modules.nixos.firefox = {
    programs.firefox = {
      enable = true;
      languagePacks = [ "en-US" ];
      preferences = { "privacy.resistFingerprinting" = true; };
      policies = { DisableTelemetry = true; };
    };
  };
}
