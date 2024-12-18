#!/bin/bash

# Verificar si se ha proporcionado una dirección o rango de IP
if [ -z "$1" ]; then
  echo "Uso: $0 <rango_de_IP>"
  exit 1
fi

# Ejecutar nmap y filtrar solo las IPs de los dispositivos con el puerto 445 abierto
sudo nmap -p 139,445 -sS --min-rate 5000 --open -vvv -n -Pn $1 | grep "Nmap scan report for" | awk '{print $5}' > ips_smb_abiertas.txt

echo "IPs guardadas en ips_smb_abiertas.txt"
