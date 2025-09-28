#!/bin/bash

# Pterodactyl Panel Setup Script (Simplified)
# NOTE: This script is a template. Real Pterodactyl installation is much more involved!
# Requires running as root or with sudo.

# --- Functions for User Input ---

get_fqdn() {
    read -p "Enter the Fully Qualified Domain Name (e.g., panel.example.com): " FQDN
    if [[ -z "$FQDN" ]]; then
        echo "FQDN cannot be empty. Exiting."
        exit 1
    fi
    echo "FQDN set to: $FQDN"
}

create_admin_user() {
    echo ""
    echo "--- Admin User Creation ---"
    read -p "Enter admin user email: " ADMIN_EMAIL
    read -p "Enter admin user username: " ADMIN_USERNAME
    read -p "Enter admin user first name: " ADMIN_FIRSTNAME
    read -p "Enter admin user last name: " ADMIN_LASTNAME

    # Prompt for password securely (hidden input)
    while true; do
        read -s -p "Enter admin user password (min 8 chars, mixed case, at least one number): " ADMIN_PASSWORD
        echo
        if [[ ${#ADMIN_PASSWORD} -ge 8 ]] && [[ "$ADMIN_PASSWORD" =~ [A-Z] ]] && [[ "$ADMIN_PASSWORD" =~ [a-z] ]] && [[ "$ADMIN_PASSWORD" =~ [0-9] ]]; then
            break
        else
            echo "Password must be at least 8 characters, mixed case, and contain at least one number."
        fi
    done

    echo "Admin details captured. The user will be created after installation."

    # In a real script, you would run the artisan command here:
    # php /var/www/pterodactyl/artisan p:user:make \
    # --email="$ADMIN_EMAIL" \
    # --username="$ADMIN_USERNAME" \
    # --name-first="$ADMIN_FIRSTNAME" \
    # --name-last="$ADMIN_LASTNAME" \
    # --password="$ADMIN_PASSWORD" \
    # --admin=1
    # echo "Admin user created successfully."
}

# --- Main Script Execution ---

echo "Starting Pterodactyl Panel Simplified Setup Script..."

# 1. Get required information
get_fqdn
create_admin_user

echo ""
echo "--- Installation Steps (Placeholders) ---"

# 2. Update System (Example for Debian/Ubuntu)
echo "Running system update..."
# apt update && apt upgrade -y

# 3. Install Dependencies (PHP, MariaDB, Nginx, Composer, etc.)
echo "Installing required packages and dependencies..."
# apt install -y software-properties-common curl apt-transport-https ca-certificates gnupg2
# (More installation commands for PHP, MariaDB, Nginx, Redis, etc.)

# 4. Configure Database
echo "Configuring MariaDB/MySQL database..."
# (Commands to create database and user for Pterodactyl)

# 5. Download and Install Panel
echo "Downloading and installing Pterodactyl Panel files..."
# (Commands to download, configure environment, and run Composer)

# 6. Run Migrations and Set Permissions
echo "Running database migrations and setting permissions..."
# (php artisan migrate --force, chown -R www-data:www-data /var/www/pterodactyl, etc.)

# 7. Create the Admin User (Using collected variables)
echo "Creating the initial Admin User..."
# (php artisan p:user:make command as specified in the function)

# 8. Configure Webserver (Nginx/Apache) with FQDN
echo "Configuring Nginx/Apache for FQDN: $FQDN"
# (Commands to create site config, enable site, and potentially use Certbot for SSL)

# 9. Set up Cronjob
echo "Setting up the Pterodactyl Cronjob..."
# (Adding * * * * * php /var/www/pterodactyl/artisan schedule:run to crontab)

echo ""
echo "--- Installation Summary ---"
echo "The script has completed its simulated steps."
echo "Panel FQDN: $FQDN"
echo "Admin User: $ADMIN_USERNAME ($ADMIN_EMAIL)"
echo "You would now navigate to https://$FQDN in your browser."
