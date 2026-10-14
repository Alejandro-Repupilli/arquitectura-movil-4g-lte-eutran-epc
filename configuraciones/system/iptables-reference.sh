#!/usr/bin/env bash
# Reglas de referencia. Revisar la política local antes de ejecutarlas.

sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE
sudo iptables -A FORWARD -i ogstun -j ACCEPT
sudo iptables -A FORWARD -o ogstun -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
