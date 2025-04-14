#!/bin/bash

while true; do

    echo "Menu de servicios"
    echo "1) Listar el contenido de un fichero (carpeta/directorio)"
    echo "2) Crear un archivo de texto con una línea de texto"
    echo "3) Comparar dos archivos de texto"
    echo "4) Mostrar uso de 'awk'"
    echo "5) Mostrar uso de 'grep'"
    echo "6) Salir"
    read -p "Selecciona una opcion: " opcion

    case $opcion in

        1)
            read -p "Ingrese la ruta absoluta de la carpeta/directorio: " dir
            if [ -d "$dir" ]; then
                ls -l "$dir"
            else
                echo "Error: La carpeta/directorio no existe."
            fi
            ;;
        2)
            read -p "Ingrese el nombre del archivo a crear (y su ruta si es necesario): " archivo
            read -p "Ingrese la línea de texto a guardar: " texto
            archivo_path="$(dirname "$0")/$archivo"
            echo "$texto" > "$archivo_path"
            echo "Archivo '$archivo' creado con éxito en $(dirname "$0")."
            ;;
        3)
            read -p "Ingrese la primer ruta a comparar: " file1
            read -p "Ingrese la segunda ruta a comparar: " file2

            # Asumir que los archivos están en el mismo directorio que el script
            file1_path="$(dirname "$0")/$file1"
            file2_path="$(dirname "$0")/$file2"

            if [ -f "$file1_path" ] && [ -f "$file2_path" ]; then
                diff "$file1_path" "$file2_path"
            else
                echo "Error: Uno o ambos archivos no existen en $(dirname "$0")."
            fi
            ;;
        4)
            echo "El uso de 'awk':"
            echo "Mostrando la tercer columna del archivo..."
            read -p "Ingresa la ruta del archivo a procesar con awk: " archivoawk
            if [ -f "$archivoawk" ]; then
                awk '{print $3}' "$archivoawk"
            else
                echo "El archivo no existe."
            fi
            ;;
        5)
            echo "El uso de 'grep':"
            read -p "Inserta la palabra a buscar: " palabra
            read -p "Ingresa la ruta del archivo donde buscar: " archivogrep
            if [ -f "$archivogrep" ]; then
                grep "$palabra" "$archivogrep"
            else
                echo "El archivo no existe."
            fi
            ;;
        6)
            echo "hasta Luego :))"
            exit 0
            ;;
        *)
            echo "Opción Invalida, intente de nuevo."
            ;;
    esac
    echo ""
done
