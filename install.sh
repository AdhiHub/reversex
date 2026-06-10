#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

REPO="AdhiHub/reversex"
BRANCH="main"
SCRIPT_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/reversex.sh"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="reversex"

echo -e "${RED}╔══════════════════════════════════════╗${RESET}"
echo -e "${RED}║      Installing ReverseX v1.0         ║${RESET}"
echo -e "${RED}╚══════════════════════════════════════╝${RESET}"
echo ""

detect_platform() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS="$ID"
    elif command -v termux-setup-storage &>/dev/null; then
        OS="termux"
    else
        OS="linux"
    fi
}

install_deps() {
    echo -e "${CYAN}[*] Installing dependencies...${RESET}"

    if command -v curl &>/dev/null; then
        echo -e "${GREEN}[+] curl already installed${RESET}"
    else
        echo -e "${YELLOW}[*] Installing curl...${RESET}"
        case "$OS" in
            termux) pkg install curl -y ;;
            ubuntu|debian) apt-get update && apt-get install curl -y ;;
            fedora|centos|rhel) yum install curl -y ;;
            arch) pacman -S curl --noconfirm ;;
            *) echo -e "${YELLOW}[!] Please install curl manually${RESET}" ;;
        esac
    fi
}

install_script() {
    echo -e "${CYAN}[*] Downloading ReverseX...${RESET}"

    if command -v curl &>/dev/null; then
        curl -fsSL "$SCRIPT_URL" -o "$SCRIPT_NAME.sh"
    elif command -v wget &>/dev/null; then
        wget -q "$SCRIPT_URL" -O "$SCRIPT_NAME.sh"
    else
        echo -e "${RED}[!] curl or wget required${RESET}"
        exit 1
    fi

    [ ! -f "$SCRIPT_NAME.sh" ] && { echo -e "${RED}[!] Download failed${RESET}"; exit 1; }

    chmod +x "$SCRIPT_NAME.sh"

    if [ "$(id -u)" -eq 0 ]; then
        mv "$SCRIPT_NAME.sh" "$INSTALL_DIR/$SCRIPT_NAME"
    else
        echo -e "${YELLOW}[*] Using sudo...${RESET}"
        sudo mv "$SCRIPT_NAME.sh" "$INSTALL_DIR/$SCRIPT_NAME"
    fi

    if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
        echo -e "${GREEN}[+] Installed to $INSTALL_DIR/$SCRIPT_NAME${RESET}"
    else
        echo -e "${RED}[!] Installation failed${RESET}"
        exit 1
    fi
}

main() {
    detect_platform
    install_deps
    install_script

    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}║  ReverseX installed!                 ║${RESET}"
    echo -e "${GREEN}║  Run: reversex                       ║${RESET}"
    echo -e "${GREEN}╚══════════════════════════════════════╝${RESET}"
    echo ""
    echo -e "${YELLOW}DISCLAIMER: Use at your own risk. Developer(s) assume NO liability.${RESET}"
}

main
