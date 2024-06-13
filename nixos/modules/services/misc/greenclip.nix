{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.greenclip;
in {

  options.services.greenclip = {
    enable = mkEnableOption "Greenclip, a clipboard manager";

    package = mkPackageOption pkgs [ "haskellPackages" "greenclip" ] { };
  };

  config = mkIf cfg.enable {
    systemd.user.services.greenclip = {
      enable      = true;
      description = "greenclip daemon";
      wantedBy = [ "graphical-session.target" ];
      after    = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/greenclip daemon";
        preStart = ''
          if [[ -z "$DISPLAY" ]]; then
            echo "can't run greenclip without DISPLAY set"
            echo "if you are using X without a display manager, please see: https://nixos.wiki/wiki/Using_X_without_a_Display_Manager"
            exit 1
          fi
        '';
        Restart = "always";
      };
    };

    environment.systemPackages = [ cfg.package ];
  };
}
