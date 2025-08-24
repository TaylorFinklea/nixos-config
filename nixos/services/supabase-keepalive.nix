{ config, lib, pkgs, ... }:

with lib;

let
  # Supabase project configuration
  projectUrl = "https://aosdhnoyiwnsvoujmobl.supabase.co";
  anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFvc2Robm95aXduc3ZvdWptb2JsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMjk1MDMsImV4cCI6MjA2MDgwNTUwM30.bh3x7A1qgF1ecSP6jH2TEJ0pW5mNb__qcFdDp5rhNWM";

  # Keep-alive script
  keepaliveScript = pkgs.writeShellScript "supabase-keepalive" ''
    set -euo pipefail

    PROJECT_URL="${projectUrl}"
    ANON_KEY="${anonKey}"

    # Log with timestamp
    log() {
        echo "$(${pkgs.coreutils}/bin/date '+%Y-%m-%d %H:%M:%S') - $1"
    }

    # Make keep-alive request with retries
    keepalive() {
        local endpoints=("/rest/v1/" "/auth/v1/settings")
        local max_retries=3

        for endpoint in "''${endpoints[@]}"; do
            for attempt in $(${pkgs.coreutils}/bin/seq 1 $max_retries); do
                log "Attempting $endpoint (try $attempt/$max_retries)"

                if ${pkgs.curl}/bin/curl -sf \
                    -H "apikey: $ANON_KEY" \
                    -H "Authorization: Bearer $ANON_KEY" \
                    --connect-timeout 30 \
                    --max-time 60 \
                    "$PROJECT_URL$endpoint" >/dev/null 2>&1; then
                    log "SUCCESS: Keep-alive successful via $endpoint"
                    return 0
                fi

                [ $attempt -lt $max_retries ] && ${pkgs.coreutils}/bin/sleep $((attempt * 2))
            done
        done

        log "ERROR: All keep-alive attempts failed"
        return 1
    }

    # Main execution
    main() {
        log "Starting Supabase keep-alive for project aosdhnoyiwnsvoujmobl"

        if keepalive; then
            log "Keep-alive completed successfully"
            exit 0
        else
            log "Keep-alive failed"
            exit 1
        fi
    }

    main "$@"
  '';

in {
  # Create a systemd service for the keep-alive
  systemd.services.supabase-keepalive = {
    description = "Supabase Keep-Alive Service";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "nobody";
      Group = "nogroup";
      ExecStart = "${keepaliveScript}";
      # Security hardening
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      RestrictNamespaces = true;
      SystemCallFilter = [ "@system-service" "~@privileged" ];
      MemoryDenyWriteExecute = true;
    };
  };

  # Create a systemd timer to run every 3 hours
  systemd.timers.supabase-keepalive = {
    description = "Run Supabase Keep-Alive every 3 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/3:00";  # Every 3 hours
      Persistent = true;        # Run missed timers on boot
      RandomizedDelaySec = 300; # Add random delay up to 5 minutes
    };
  };

  # Enable the timer by default
  systemd.timers.supabase-keepalive.enable = true;

  # Optional: Create a user command to manually trigger the service
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "supabase-keepalive-manual" ''
      echo "Manually triggering Supabase keep-alive..."
      sudo systemctl start supabase-keepalive.service
      echo "Check status with: sudo systemctl status supabase-keepalive.service"
      echo "Check logs with: sudo journalctl -u supabase-keepalive.service"
    '')
  ];
}
