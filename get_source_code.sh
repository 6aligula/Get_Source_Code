#!/bin/bash

# Define la URL del portal de noticias
url="https://www.elperiodico.com/es/sociedad/20240226/cambios-preinscripciones-fp-educacion-reserva-plazas-98667630"

# Define el directorio y el nombre del archivo de salida
output_file="/data/elpais_source.html"

# Comprueba si wget o curl están instalados
if command -v wget &> /dev/null; then
    downloader="wget -q -O - \"$url\" > \"$output_file\""
elif command -v curl &> /dev/null; then
    downloader="curl -s \"$url\" > \"$output_file\""
else
    echo "Ni wget ni curl están instalados. Intentando instalar wget..."
    apt-get update && apt-get install wget -y
    if command -v wget &> /dev/null; then
        echo "wget instalado con éxito."
        downloader="wget -q -O - \"$url\" > \"$output_file\""
    else
        echo "No se pudo instalar wget. Abortando..."
        exit 1
    fi
fi

# Ejecuta el comando de descarga seleccionado
eval $downloader

# Comprueba si el archivo se descargó correctamente
if [ ! -s "$output_file" ]; then
    echo "Error al descargar el código fuente de la página. Verifica la URL y tu conexión a internet."
    exit 1
else
    echo "Descarga completada. Archivo HTML guardado como $output_file"
fi
