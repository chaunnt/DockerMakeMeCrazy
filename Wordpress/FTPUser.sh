#!/bin/bash
set -e

# === CONSTANTS ===
PROJECT_NAME="myproject"        # Change this to your project name
FTP_USER="${PROJECT_NAME}_ftp"  # e.g., myproject_ftp
FTP_PASS="${PROJECT_NAME}_pass" # e.g., myproject_pass
FTP_FOLDER="/var/lib/docker/volumes/captain--toritech-wp-company-wp-data/_data"
VSFTPD_CONF="/etc/vsftpd.conf"
CHROOT_LIST="/etc/vsftpd.chroot_list"

# === 1. Detect OS & Install vsftpd ===
install_vsftpd() {
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y vsftpd
    elif command -v yum &>/dev/null; then
        sudo yum install -y vsftpd
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y vsftpd
    elif command -v apk &>/dev/null; then
        sudo apk add vsftpd
    else
        echo "❌ No supported package manager found. Install vsftpd manually."
        exit 1
    fi
}

if [ ! -f "$VSFTPD_CONF" ]; then
    echo "📦 Installing vsftpd..."
    install_vsftpd
fi

# === 2. Create FTP user ===
if id "$FTP_USER" &>/dev/null; then
    echo "User $FTP_USER already exists."
else
    echo "Creating FTP user..."
    sudo adduser --disabled-password --gecos "" "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | sudo chpasswd
fi

# === 3. Set folder ownership ===
sudo chown -R "$FTP_USER":"$FTP_USER" "$FTP_FOLDER"
sudo chmod 755 "$FTP_FOLDER"

# === 4. Backup vsftpd config ===
sudo cp "$VSFTPD_CONF" "$VSFTPD_CONF.bak"

# === 5. Update vsftpd.conf automatically ===
sudo sed -i '/^local_enable/d' "$VSFTPD_CONF"
sudo sed -i '/^write_enable/d' "$VSFTPD_CONF"
sudo sed -i '/^chroot_local_user/d' "$VSFTPD_CONF"
sudo sed -i '/^allow_writeable_chroot/d' "$VSFTPD_CONF"
sudo sed -i '/^user_sub_token/d' "$VSFTPD_CONF"
sudo sed -i '/^local_root/d' "$VSFTPD_CONF"
sudo sed -i '/^chroot_list_enable/d' "$VSFTPD_CONF"
sudo sed -i '/^chroot_l_
