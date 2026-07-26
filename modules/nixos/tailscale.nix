{ lib, config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
  };

  # tailscale >=1.90 seals its state file to the TPM (kept on, because this
  # disk is unencrypted, so the node key must not sit in plaintext). A failed
  # unseal crash-loops the daemon, and each attempt pumps the TPM's
  # dictionary-attack counter until it locks out ("503: no backend"). Throttle
  # restarts so a single transient failure can never escalate into a full
  # lockout again: back off 10s, and give up after 3 attempts in 2 minutes.
  systemd.services.tailscaled = {
    serviceConfig.RestartSec = 10;
    startLimitIntervalSec = 120;
    startLimitBurst = 3;
  };
}
