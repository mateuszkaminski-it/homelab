#!/bin/bash
# Backup udzialu /srv/share z ACL - v2
set -e

ZRODLO=/srv/share
CEL=/backup
LOG=/var/log/backup-share.log
DATA=$(date +%F_%H%M)
PLIK="$CEL/share-$DATA.tar.gz"

echo "$(date) START" >> "$LOG"

# share musi byc zamontowany
if ! mountpoint -q "$ZRODLO"; then
  echo "$(date) BLAD: $ZRODLO niezamontowany" >> "$LOG"
  exit 1
fi

tar --acls --xattrs -czpf "$PLIK" -C /srv share
echo "$(date) OK: $PLIK" >> "$LOG"

find "$CEL" -name 'share-*.tar.gz' -mtime +7 -delete
echo "$(date) KONIEC" >> "$LOG"
