#!/bin/bash

# Verificar argumentos
if [ "$#" -ne 8 ]; then
    echo "Uso: $0 <Nombre_VM> <SO> <CPUs> <RAM_GB> <VRAM_MB> <Tamaño_Disco_GB> <Controlador_SATA> <Controlador_IDE>"
 
    exit 1
fi

# Asignación de variables
NOMBRE_VM=$1
SO=$2
CPUS=$3
RAM_MB=$(($4 * 1024))
VRAM_MB=$5
DISCO_GB=$6
CONTROLADOR_SATA=$7
CONTROLADOR_IDE=$8

# Crear carpeta para la VM
DirNewVM="$HOME/VMs/$NOMBRE_VM"
mkdir -p "$DirNewVM"

# Ruta archivo disco virtual (.vmdk)
virtualDiscoVMDK="$DirNewVM/$NOMBRE_VM.vmdk"

# Crear archivo de configuración de la máquina virtual (.vmx)
echo "Archivo de configuración de máquina virtual"
cat <<EOL > "$DirNewVM/$NOMBRE_VM.vmx"
config.version = "8"
virtualHW.version = "14"
displayName = "$NOMBRE_VM"
guestOS = "$SO"
memsize = "$RAM_MB"
numvcpus = "$CPUS"
vramSize = "$VRAM_MB"
scsi0.present = "TRUE"
scsi0.virtualDev = "lsisas1068"
scsi0:0.present = "TRUE"
scsi0:0.fileName = "$virtualDiscoVMDK"
scsi0:0.deviceType = "scsi-hardDisk"
ide1:0.present = "TRUE"
ide1:0.deviceType = "cdrom-raw"
EOL

# Creando el disco duro virtual (.vmdk)
echo "El disco virtual es de ${DISCO_GB} GB..."
fallocate -l "${DISCO_GB}G" "$virtualDiscoVMDK" 2>/dev/null || touch "$virtualDiscoVMDK"

echo "---------------------------------------------"
echo "Máquina virtual '$NOMBRE_VM' creada y su configuracion es:"
echo "  - SO: $SO"
echo "  - $CPUS CPUs"
echo "  - $RAM_MB GB de RAM"
echo "  - $VRAM_MB MB de VRAM"
echo "  - El Disco de ${DISCO_GB} GB"
echo "  - Controlador SATA: $CONTROLADOR_SATA"
echo "  - Controlador IDE: $CONTROLADOR_IDE"
echo "---------------------------------------------"
