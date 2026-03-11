#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

log_dir="/home/kali/check_services.log"
mkdir -p "log_dir"

HOSTNAME=$(hostname)
DATE=$(date '+%Y%m%d_%H%M%S')
log_file="$log_dir/${HOSTNAME}-${DATE}.log"

{
echo "======Check time:$(date '+%Y-%m-%d %H:%M:%S')====="
echo "主機名稱：$(hostname)"
echo "-------------------------------"

# 🔍 檢查是否可以連線到外部網路
target="8.8.8.8"
echo "網路服務:檢查是否可以連線到 $target ..."

if ping -c 1 -W 2 $target > /dev/null 2>&1; then
    echo -e "\e[32m✅ 網路通暢\e[0m：可以連接到 $target"
else
    echo -e "\e[31m⚠️  網路異常\e[0m：無法連接到 $target"
fi

echo "-------------------------------"
echo "正在檢查常見網路服務連線狀態..."
echo "-------------------------------"

# 定義常見服務與對應的 port
declare -A services=(
   [SSH]=22
#  [HTTP]=80
   [HTTPS]=443
#  [FTP]=21
   [MySQL]=3306
#  [PostgreSQL]=5432
#  [DNS]=53
#  [SMTP]=25
#  [IMAP]=143
#  [POP3]=110
#  [Samba]=445
#  [NFS]=2049
#  [OpenVPN]=1194
)

# 檢查每個服務的 port 是否有監聽
for service in "${!services[@]}"; do
    port=${services[$service]}
    if ss -tuln | grep -q ":$port "; then
        echo -e "✅ $service (port $port)：\e[32m已開啟\e[0m"
    else
        echo -e "❌ $service (port $port)：\e[31m未開啟\e[33m 服務異常\e[0m"
    fi
done

echo "-------------------------------"
echo ""
} > "$log_file"

cat $log_file

if [ -f "$log_file" ]; then
	gzip -f "$log_file"
fi
