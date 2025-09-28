#!/bin/bash

# =======================
#   SHADOW Menu Script
# =======================

# Colors
BLACK='\033[1;30m'
RED='\033[1;31m'
PURPLE='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m' # Reset

# Emojis
FIRE="🔥"
SPARK="⚡"
GHOST="👻"
MENU_ICON="📜"
TRASH="🗑️"
CLOUD="☁️"
HAMMER="🛠️"
BLUEPRINT="🧩"
PALETTE="🎨"
INFO="ℹ️"

# Spinner animation
spinner() {
    local pid=$!
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    tput civis
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %10 ))
        printf " ${PURPLE}${SPARK}${NC} ${RED}${spin:$i:1}${NC} ${BLACK}Processing...${NC}\r"
        sleep 0.1
    done
    tput cnorm
}

# Intro animation
intro_animation() {
    clear
    text="POWERED BY - SHADOW"
    echo -ne "${PURPLE}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.07
    done
    echo -e "${NC}\n"
    sleep 0.5

    # Emoji wave animation
    wave="👻🔥⚡☁️"
    for ((i=0; i<3; i++)); do
        for e in $(echo $wave | fold -w1); do
            echo -ne "${RED}$e ${NC}"
            sleep 0.1
        done
        echo
        sleep 0.2
    done

    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    sleep 0.5
}

# Banner
banner() {
    clear
    echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "         ${WHITE}POWERED BY - ${PURPLE}SHADOW${NC}"
    echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
}

# Menu
menu() {
    banner
    echo -e "${MENU_ICON} ${WHITE}Choose an option:${NC}"
    echo -e "  1) ${FIRE} ${PURPLE}Install Panel${NC}"
    echo -e "  2) ${SPARK} ${PURPLE}Install Wings${NC}"
    echo -e "  3) ${TRASH} ${RED}Uninstall Panel/Wings${NC}"
    echo -e "  4) ${HAMMER} ${PURPLE}Update Pterodactyl${NC}"
    echo -e "  5) ${BLUEPRINT} ${PURPLE}Install Blueprint${NC}"
    echo -e "  6) ${PALETTE} ${PURPLE}Install Theme${NC}"
    echo -e "  7) ${CLOUD} ${PURPLE}Install Cloudflared${NC}"
    echo -e "  8) ${INFO} ${PURPLE}Info${NC}"
    echo -e "  0) ${GHOST} ${RED}Exit${NC}"
    echo
    read -p "Enter choice: " choice

    # If user presses Enter (empty input), reload menu
    if [[ -z "$choice" ]]; then
        menu
        return
    fi

    case $choice in
        1)
            echo -e "\n${SPARK} ${WHITE}Starting Panel installation...${NC}"
            (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/Panel.sh)) & spinner
            echo -e "\n${FIRE} ${PURPLE}Panel installation complete!${NC}\n"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        2)
            echo -e "\n${SPARK} ${WHITE}Starting Wings installation...${NC}"
            (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/Wings.sh)) & spinner
            echo -e "\n${FIRE} ${PURPLE}Wings installation complete!${NC}\n"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        3)
            echo -e "\n${TRASH} ${WHITE}Uninstall Panel/Wings selected.${NC}"
            read -p "$(echo -e ${RED}Are you sure you want to uninstall? (y/n):${NC} ) " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/Uninstall.sh)) & spinner
                echo -e "\n${RED}❌ Panel/Wings Uninstalled!${NC}\n"
            else
                echo -e "\n${RED}❌ Uninstall aborted by user!${NC}\n"
            fi
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        4)
            echo -e "\n${HAMMER} ${WHITE}Update Pterodactyl selected.${NC}"
            read -p "$(echo -e ${PURPLE}Are you sure you want to update? (y/n):${NC} ) " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/update.sh)) & spinner
                echo -e "\n${FIRE} ${PURPLE}Pterodactyl update completed!${NC}\n"
            else
                echo -e "\n${RED}❌ Update aborted by user!${NC}\n"
            fi
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        5)
            echo -e "\n${BLUEPRINT} ${WHITE}Installing Blueprint...${NC}"
            (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/Blueprint.sh)) & spinner
            echo -e "\n${BLUEPRINT} ${PURPLE}Blueprint installed successfully!${NC}\n"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        6)
            echo -e "\n${PALETTE} ${WHITE}Installing Theme...${NC}"
            (bash <(curl -s https://raw.githubusercontent.com/hishadow1/All-in-one/main/theme.sh)) & spinner
            echo -e "\n${PALETTE} ${PURPLE}Theme installed successfully!${NC}\n"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        7)
            echo -e "\n${CLOUD} ${WHITE}Installing Cloudflared...${NC}"
            (
                sudo mkdir -p --mode=0755 /usr/share/keyrings
                curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
                echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
                sudo apt-get update && sudo apt-get install -y cloudflared
            ) & spinner

            echo -e "\n${SPARK} ${PURPLE}Cloudflared installed successfully!${NC}"
            echo -e "${WHITE}Now enter your Cloudflare token:${NC}"
            read -p "Token: " cf_token

            if [ -n "$cf_token" ]; then
                sudo cloudflared service install "$cf_token"
                echo -e "\n${FIRE} ${PURPLE}Cloudflared connected with your token!${NC}\n"
            else
                echo -e "\n${RED}❌ No token entered. Skipping installation.${NC}\n"
            fi

            read -p "Press Enter to return to main menu..."
            menu
            ;;
        8)
            echo -e "\n${INFO} ${PURPLE}Script Info${NC}"
            echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${WHITE}Branding   : ${PURPLE}SHADOW${NC}"
            echo -e "${WHITE}Theme      : ${RED}Black/Red/Purple Modern UI${NC}"
            echo -e "${WHITE}Features   : ${PURPLE}Installer Menu, Spinner, Animations, Emojis${NC}"
            echo -e "${WHITE}Created By : ${RED}SHADOW${NC}"
            echo -e "${WHITE}Version    : ${PURPLE}v1.1${NC}"
            echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            
            echo -e "\n${INFO} ${PURPLE}System Info${NC}"
            echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${WHITE}OS         : ${PURPLE}$(lsb_release -d 2>/dev/null | cut -f2 || echo "Unknown")${NC}"
            echo -e "${WHITE}Kernel     : ${PURPLE}$(uname -r)${NC}"
            echo -e "${WHITE}Uptime     : ${PURPLE}$(uptime -p)${NC}"
            echo -e "${WHITE}CPU        : ${PURPLE}$(lscpu | grep 'Model name' | cut -d ':' -f2 | xargs)${NC}"
            echo -e "${WHITE}Cores      : ${PURPLE}$(nproc)${NC}"
            echo -e "${WHITE}RAM        : ${PURPLE}$(free -h --si | awk '/Mem:/ {print $2 " total, " $3 " used"}')${NC}"
            echo -e "${WHITE}Disk       : ${PURPLE}$(df -h --total | grep total | awk '{print $2 " total, " $3 " used"}')${NC}"
            echo -e "${BLACK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
        0)
            echo -e "${GHOST} ${RED}Exiting... Goodbye from SHADOW!${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}❌ No option found!${NC}"
            read -p "Press Enter to return to main menu..."
            menu
            ;;
    esac
}

# Run
intro_animation
menu
