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
  # 2026-08-25: the flag above is necessary but was NOT sufficient, and on its
  # own it made things strictly worse. --encrypt-state=false does not mean
  # "ignore the TPM" -- it means "state must be plaintext", which tailscaled
  # enforces by MIGRATING an existing sealed file, and migration has to unseal
  # it first. So while a sealed tailscaled.state existed, every single start
  # attempted an unseal, failed with TPM_RC_LOCKOUT, and re-armed the 2h
  # lockout timer. The counter could never drain and the daemon never once
  # started. Fix was to take the sealed blob out of the path entirely:
  #   systemctl stop tailscaled && systemctl reset-failed tailscaled
  #   mv /var/lib/tailscale/tailscaled.state{,.tpm-sealed.bak}
  #   systemctl start tailscaled && tailscale up   # re-auths, new node identity
  # With no state file present tailscaled writes a fresh plaintext store and
  # never touches the TPM again. The old node key is unrecoverable (sealed to a
  # TPM that will not unseal it); that was accepted rather than chased.
  #
  # To restore sealing: clear the TPM from firmware setup (safe here -- nothing
  # else uses it, and Secure Boot keys live in NVRAM), drop the flag above,
  # remove the stale state file, and re-run `tailscale up`.
  #
  # The 2-starts-per-day throttle that used to live here existed to stop a bad
  # state file cascading into a lockout. That is no longer reachable: with a
  # plaintext store the start path makes no DA-protected TPM call, so a restart
  # loop cannot lock anything out. The throttle only survived to turn a
  # transient failure into a 24h outage ("Start request repeated too quickly"
  # on a manual `systemctl start`), so it is relaxed to ordinary values.
  # Reinstate the harsh limits if --encrypt-state=false is ever dropped.
  systemd.services.tailscaled = {
    serviceConfig.RestartSec = 10;
    startLimitIntervalSec = 300;
    startLimitBurst = 5;
  };
}
