# Homelab – Ubuntu Server

Home lab on VMware Workstation, built to practice Linux system administration.

## What's inside
- **Samba file share** – LVM volume (ext4), group-based permissions (setgid, 2770), access from Windows
- **Automated backup** – bash script with mount check and logging, run by a systemd timer (`Persistent=true`, `RequiresMountsFor`)
- **Log rotation** – logrotate (weekly, 4 copies, compressed)
- **SSH hardening** – key-only login (ed25519), password and root login disabled
- **Firewall** – ufw, SSH and Samba allowed only from the local subnet

## Lessons learned
Found a silent bug: after reboot, the timer ran before the share was mounted, so backups were empty but reported success. Fixed with `RequiresMountsFor=/srv/share` plus a `mountpoint` check in the script.

## Structure
- `scripts/` – backup script
- `systemd/` – service + timer units
- `logrotate/` – log rotation config
- `ssh/` – sshd drop-in config
- `samba/` – smb.conf





---

## 🇵🇱 Po polsku

Domowe laboratorium na VMware Workstation do nauki administracji Linuxem.

**Co zawiera:**
- **Udział Samba** – wolumen LVM (ext4), uprawnienia grupowe (setgid, 2770), dostęp z Windows
- **Automatyczny backup** – skrypt bash ze sprawdzeniem montowania i logowaniem, uruchamiany przez systemd timer (`Persistent=true`, `RequiresMountsFor`)
- **Rotacja logów** – logrotate (co tydzień, 4 kopie, kompresja)
- **Zabezpieczenie SSH** – logowanie tylko kluczem (ed25519), wyłączone hasła i logowanie roota
- **Firewall** – ufw, SSH i Samba dostępne tylko z sieci lokalnej

**Czego się nauczyłem:**
Znalazłem cichy błąd: po restarcie timer uruchamiał backup, zanim udział został zamontowany, więc kopie były puste, a skrypt zgłaszał sukces. Naprawione przez `RequiresMountsFor=/srv/share` i sprawdzenie `mountpoint` w skrypcie.
