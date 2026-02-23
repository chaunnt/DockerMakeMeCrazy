#!/bin/bash
set -euo pipefail

#01 Nhận tham số đầu vào
echo "#01 Nhận tham số đầu vào"
USERNAME="$1"
APP_DIR="$2"

#02 Gán giá trị mặc định nếu không truyền
echo "#02 Gán giá trị mặc định nếu không truyền"
if [ -z "$USERNAME" ]; then
    USERNAME="tracuuphatxe"
fi

if [ -z "$APP_DIR" ]; then
    APP_DIR="/var/lib/docker/volumes/captain--blog-tracuuphatxe-wp-wp-data/_data"
fi
BASE_DIR="/home/$USERNAME"
USER_WORK_DIR="$BASE_DIR/data"
SSHD_CONFIG="/etc/ssh/sshd_config"

#03 Nếu truyền path volume gốc thì tự động trỏ vào _data
echo "#03 Chuẩn hóa APP_DIR về thư mục _data"
if [ -d "$APP_DIR/_data" ]; then
    APP_DIR="$APP_DIR/_data"
fi

echo "================================="
echo "Recreating SFTP user"
echo "Username: $USERNAME"
echo "Docker volume: $APP_DIR"
echo "================================="

#04 Kiểm tra docker volume tồn tại
echo "#04 Kiểm tra docker volume tồn tại"
if [ ! -d "$APP_DIR" ]; then
    echo "ERROR: Directory not found: $APP_DIR"
    exit 1
fi

#05 Unmount thư mục work cũ nếu đang mount
echo "#05 Unmount thư mục work cũ nếu đang mount"
if mountpoint -q "$USER_WORK_DIR"; then
    umount "$USER_WORK_DIR"
fi

#06 Xoá fstab entry cũ
echo "#06 Xoá fstab entry cũ"
sed -i "\|$USER_WORK_DIR|d" /etc/fstab

#07 Xoá SSH Match config cũ của user
echo "#07 Xoá SSH Match config cũ của user"
sed -i "/Match User $USERNAME/,+6d" "$SSHD_CONFIG"

#08 Restart SSH để áp config sạch
echo "#08 Restart SSH để áp config sạch"
systemctl restart ssh

#09 Xoá user cũ nếu tồn tại
echo "#09 Xoá user cũ nếu tồn tại"
if id "$USERNAME" &>/dev/null; then
    userdel "$USERNAME"
fi

#10 Xoá home cũ còn sót
echo "#10 Xoá home cũ còn sót"
rm -rf "$BASE_DIR"

#11 Tạo password mới
echo "#11 Tạo password mới"
PASSWORD=$(openssl rand -base64 18)

#12 Tạo user SFTP mới
echo "#12 Tạo user SFTP mới"
useradd -m -d "$BASE_DIR" -s /usr/sbin/nologin "$USERNAME"

echo "$USERNAME:$PASSWORD" | chpasswd

#13 Tạo thư mục làm việc trong chroot
echo "#13 Tạo thư mục làm việc trong chroot"
mkdir -p "$USER_WORK_DIR"

#14 Bind mount docker volume vào /home/<user>/data
echo "#14 Bind mount docker volume vào /home/<user>/data"
mount --bind "$APP_DIR" "$USER_WORK_DIR"

#15 Persist bind mount qua /etc/fstab
echo "#15 Persist bind mount qua /etc/fstab"
echo "$APP_DIR $USER_WORK_DIR none bind 0 0" >> /etc/fstab

#16 Set permission cho thư mục chroot
echo "#16 Set permission cho thư mục chroot"
chown root:root "$BASE_DIR"
chmod 755 "$BASE_DIR"

chown "$USERNAME:$USERNAME" "$USER_WORK_DIR"
chmod 700 "$USER_WORK_DIR"

#17 Đảm bảo user có quyền ghi trên thư mục dữ liệu thật
echo "#17 Đảm bảo user có quyền ghi trên thư mục dữ liệu thật"
if command -v setfacl >/dev/null 2>&1; then
    setfacl -R -m "u:$USERNAME:rwX" "$APP_DIR"
    setfacl -R -m "d:u:$USERNAME:rwX" "$APP_DIR"
else
    chown -R "$USERNAME:$USERNAME" "$APP_DIR"
    chmod -R u+rwX "$APP_DIR"
fi

#18 Thêm cấu hình SSH jail cho user
echo "#18 Thêm cấu hình SSH jail cho user"
cat <<EOF >> "$SSHD_CONFIG"

Match User $USERNAME
    ChrootDirectory $BASE_DIR
    ForceCommand internal-sftp
    X11Forwarding no
    AllowTcpForwarding no
    PasswordAuthentication yes
EOF

#19 Restart SSH để áp cấu hình mới
echo "#19 Restart SSH để áp cấu hình mới"
systemctl restart ssh

echo ""
echo "================================="
echo "SFTP USER READY"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo ""
echo "SFTP path: /data"
echo "Real path: $APP_DIR"
echo "================================="
