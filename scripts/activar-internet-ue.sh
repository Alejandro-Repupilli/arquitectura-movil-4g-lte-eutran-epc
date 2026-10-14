#!/usr/bin/env bash
set -euo pipefail

NS="ue1"
DEV="tun_srsue"

if ! sudo ip netns exec "$NS" ip link show "$DEV" >/dev/null 2>&1; then
    echo "ERROR: No existe $DEV dentro de $NS."
    echo "Primero inicia srsENB y srsUE y espera el attach exitoso."
    exit 1
fi

sudo ip netns exec "$NS" ip route replace default dev "$DEV"

echo "Ruta del UE:"
sudo ip netns exec "$NS" ip route

echo
echo "Probando núcleo LTE..."
sudo ip netns exec "$NS" ping -c 2 10.45.0.1

echo
echo "Probando Internet..."
sudo ip netns exec "$NS" ping -c 2 1.1.1.1

echo
echo "Probando DNS..."
sudo ip netns exec "$NS" getent hosts github.com
