#!/bin/bash

# Colores
reset="\e[0m"
amarillo="\e[38;5;228m"
verde="\e[32m"
cian="\e[36m"
verde_oscuro="\e[92m"

title(){
    echo -e "${verde}\n   Información del sistema${reset}"
    echo -e "\n---------------------------------------------\n"
}

user(){
    user=$(whoami)
    echo -e "\n${cian}Usuario:${reset} ${user}"
}

distro(){
    os=$(uname)
    distro="$(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')"
    shell="$(echo $SHELL | awk -F'/' '{print $NF}')"
    echo -e "${cian}Sistema operativo:${reset} ${os}"
    echo -e "${cian}Distribución:${reset} ${distro}"
    echo -e "${cian}Shell:${reset} ${shell}"
}

kernel_info(){
    kernel_version="$(uname -r)"
    architecture=$(uname -i)
    echo -e "${cian}Versión del kernel:${reset} ${kernel_version}"
    echo -e "${cian}Arquitectura:${reset} ${architecture}"
}

information_hardware(){
    brand="$(cat /sys/class/dmi/id/sys_vendor 2>/dev/null || echo "Información no disponible")"
    model="$(cat /sys/class/dmi/id/product_version 2>/dev/null || echo "Información no disponible")"
    disk="$(lsblk -d -o NAME,SIZE | awk 'NR>1 {printf "\n  %s %s", $1, $2}')"
    memory="$(free -h | awk '/^Mem:/ {print $2}')"
    cpu="$(grep "model name" /proc/cpuinfo | uniq | awk -F':' '{print $2}')"
    gpus=$(lspci | grep -i vga | awk -F': ' '{printf "\033[36mGPU:\033[0m %s\n", $2}')
    echo -e "${cian}Marca:${reset} ${brand}"
    echo -e "${cian}Modelo:${reset} ${model}"
    echo -e "${cian}Dispositivos de almacenamiento:${reset}${disk}"
    echo -e "${cian}Memoria RAM:${reset} ${memory}"
    echo -e "${cian}CPU:${reset}${cpu}"
    echo -e "${gpus}\n"
}

clear
title
user
distro
kernel_info
information_hardware
