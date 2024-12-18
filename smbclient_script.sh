#!/bin/bash

# Archivo con la lista de IPs
input_file="ips_smb_abiertas.txt"
# Archivo donde se guardarán los outputs válidos
output_file="smbmap_outputs_validos.txt"

# Limpiar el archivo de salida antes de usarlo
> "$output_file"

# Leer cada línea del archivo
while IFS= read -r line; do
    # Extraer las IPs usando una expresión regular
    if [[ $line =~ ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) ]]; then
        ip="${BASH_REMATCH[1]}"
        echo "Ejecutando smbmap para la IP: $ip"
        
        # Ejecutar smbmap para la IP extraída y redirigir stderr a stdout
        output=$(smbmap -H "$ip" -u 'guest' -p 'xxxxx' -d 'xxxxx' 2>&1)
        
        # Comprobar si el output contiene "Authentication error"
        if ! echo "$output" | grep -q "Authentication error"; then
            # Guardar el output válido en el archivo
            echo "Output válido para la IP: $ip" >> "$output_file"
            echo "$output" >> "$output_file"
            echo "---------------------------------------" >> "$output_file"
        fi
    fi
done < "$input_file"

echo "Todos los outputs válidos han sido guardados en $output_file"
