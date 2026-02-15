#!/bin/bash

USERNAME="tracuuphatxe"
BASE_DIR="/home/$USERNAME"
APP_DIR="/var/lib/docker/volumes/captain--blog-tracuuphatxe-wp-wp-data"

# 1. Tạo mật khẩu mạnh ngẫu nhiên
PASSWORD=$(openssl rand -base64 18)

# 2. Tạo user (không cho tạo home tự động)
useradd -m -d $BASE_DIR -s /bin/bash $USERNAME

# 3. Set mật khẩu
echo "$USERNAME:$PASSWORD" | chpasswd

# 4. Tạo thư mục được phép truy cập
mkdir -p $APP_DIR

# 5. Thiết lập quyền
# Chroot yêu cầu thư mục gốc phải thuộc root
chown root:root $BASE_DIR
chmod 755 $BASE_DIR

# Thư mục làm việc thực tế thuộc user
chown $USERNAME:$USERNAME $APP_DIR
chmod 700 $APP_DIR

# 6. Cấu hình SSH giới hạn user này
SSHD_CONFIG="/etc/ssh/sshd_config"

# Xóa cấu hình cũ nếu có
sed -i "/Match User $USERNAME/,+6d" $SSHD_CONFIG

cat <<EOF >> $SSHD_CONFIG

Match User $USERNAME
    ChrootDirectory $BASE_DIR
    ForceCommand internal-sftp
    X11Forwarding no
    AllowTcpForwarding no
EOF

# 7. Restart SSH
systemctl restart sshd 2>/dev/null || systemctl restart ssh

echo "======================================"
echo "User created successfully!"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo "Accessible directory: $APP_DIR"
echo "======================================"
