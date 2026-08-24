{ lib, config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;

    # TPM state sealing is DISABLED, so the node key is stored in plaintext at
    # /var/lib/tailscale/tailscaled.state on this unencrypted disk. This is a
    # deliberate downgrade taken on 2026-08-24 to escape a TPM dictionary-attack
    # lockout (see below); revisit once the TPM is usable again.
    extraDaemonFlags = [ "--encrypt-state=false" ];
  };

  # Why sealing was turned off: tailscale >=1.90 seals its state file to the TPM
  # by default. A failed unseal crash-loops the daemon, and each attempt pumps
  # the TPM's dictionary-attack counter. On this machine that counter reached
  # maxAuthFail (10) and the TPM entered lockout, so every unseal returned
  # TPM_RC_LOCKOUT and tailscaled could not start at all.
  #
  # Measured DA parameters on this box (tpm2_getcap properties-variable):
  #   maxAuthFail 10, lockoutInterval 7200s, lockoutRecovery 7200s
  #   lockoutAuthSet 1 (firmware-set, unknown), disableClear 1
  # The counter drains by 1 per 2h, so recovery leaves it at 9/10 -- a single
  # further failure re-locks it. lockoutAuth is itself DA-protected, so
  # tpm2_dictionarylockout --clear-lockout is refused while inLockout.
  #
  # Note tailscale does NOT bind the seal to PCR values (no PolicyPCR/
  # PolicySession in the binary), so lanzaboote/Secure Boot measurement changes
  # were ruled out as the trigger. The cause was the crash-loop itself.
  #
  # To restore sealing: clear the TPM from firmware setup (safe here -- nothing
  # else uses it, and Secure Boot keys live in NVRAM), drop the flag above,
  # remove the stale state file, and re-run `tailscale up`.
  #
  # Throttle restarts hard regardless, so a bad state file can never again
  # cascade into a lockout: wait 60s between attempts, and allow at most 2 per
  # day against a counter that only drains 12/day.
  systemd.services.tailscaled = {
    serviceConfig.RestartSec = 60;
    startLimitIntervalSec = 86400;
    startLimitBurst = 2;
  };
}
