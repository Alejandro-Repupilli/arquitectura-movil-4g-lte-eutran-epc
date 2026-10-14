#!/usr/bin/env bash
set -euo pipefail

NS="ue1"

echo "Preparando el namespace $NS..."
sudo ip netns add "$NS" 2>/dev/null || true
sudo install -d -m 755 "/etc/netns/$NS"

printf 'nameserver 1.1.1.1\nnameserver 8.8.8.8\n' |
    sudo tee "/etc/netns/$NS/resolv.conf" >/dev/null

echo
echo "Namespace disponible:"
sudo ip netns list

echo
echo "DNS configurado:"
sudo cat "/etc/netns/$NS/resolv.conf"

echo
echo "Preparación finalizada."
echo "Ahora inicia srsENB y después srsUE."
