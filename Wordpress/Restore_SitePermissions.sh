#!/bin/bash
set -euo pipefail

#01 Nhận tham số đầu vào
echo "#01 Nhận tham số đầu vào"
APP_DIR="${1:-/var/lib/docker/volumes/captain--blog-tracuuphatxe-wp-wp-data/_data}"
WEB_USER="${2:-www-data}"
SFTP_USER="${3:-}"

#02 Kiểm tra quyền root
echo "#02 Kiểm tra quyền root"
if [ "${EUID}" -ne 0 ]; then
  echo "ERROR: Vui lòng chạy script bằng root hoặc sudo"
  exit 1
fi

#03 Chuẩn hóa APP_DIR về thư mục _data nếu cần
echo "#03 Chuẩn hóa APP_DIR về thư mục _data"
if [ -d "$APP_DIR/_data" ]; then
  APP_DIR="$APP_DIR/_data"
fi

#04 Kiểm tra thư mục dữ liệu tồn tại
echo "#04 Kiểm tra thư mục dữ liệu tồn tại"
if [ ! -d "$APP_DIR" ]; then
  echo "ERROR: Không tìm thấy thư mục dữ liệu: $APP_DIR"
  exit 1
fi

#05 Kiểm tra user web tồn tại
echo "#05 Kiểm tra user web tồn tại"
if ! id "$WEB_USER" >/dev/null 2>&1; then
  echo "ERROR: User web không tồn tại: $WEB_USER"
  exit 1
fi

#06 Khôi phục owner cho web server
echo "#06 Khôi phục owner cho web server"
chown -R "$WEB_USER:$WEB_USER" "$APP_DIR"

#07 Khôi phục permission chuẩn cho WordPress
echo "#07 Khôi phục permission chuẩn cho WordPress"
find "$APP_DIR" -type d -exec chmod 755 {} \;
find "$APP_DIR" -type f -exec chmod 644 {} \;

#07.1 Khôi phục ACL để không mất quyền ghi của user SFTP
echo "#07.1 Khôi phục ACL để giữ quyền ghi SFTP"
if command -v setfacl >/dev/null 2>&1; then
  setfacl -R -m m::rwX "$APP_DIR"
  setfacl -R -m d:m::rwX "$APP_DIR"

  if [ -n "$SFTP_USER" ]; then
    if id "$SFTP_USER" >/dev/null 2>&1; then
      setfacl -R -m "u:$SFTP_USER:rwX" "$APP_DIR"
      setfacl -R -m "d:u:$SFTP_USER:rwX" "$APP_DIR"
    else
      echo "WARN: SFTP user không tồn tại: $SFTP_USER (bỏ qua cấp ACL trực tiếp)"
    fi
  fi
else
  echo "WARN: setfacl không có trên hệ thống, không thể khôi phục ACL SFTP tự động"
fi

#08 Đảm bảo .htaccess đọc được
echo "#08 Đảm bảo .htaccess đọc được"
if [ -f "$APP_DIR/.htaccess" ]; then
  chmod 644 "$APP_DIR/.htaccess"
fi

#09 In thông tin kết quả
echo "#09 In thông tin kết quả"
echo "================================="
echo "SITE PERMISSIONS RESTORED"
echo "APP_DIR : $APP_DIR"
echo "WEB_USER: $WEB_USER"
if [ -n "$SFTP_USER" ]; then
  echo "SFTP_USER: $SFTP_USER"
fi
echo "================================="
