#!/bin/bash

# 顯示主機名稱
echo "主機名稱：$(hostname)"

echo "磁碟使用情況："

# 使用 df 取得磁碟使用資訊（排除 tmpfs 和 udev 等虛擬系統）
df -h --output=target,pcent | grep -vE '^Mounted on' | while read line; do
    mount_point=$(echo $line | awk '{print $1}')
    usage_percent=$(echo $line | awk '{print $2}' | tr -d '%')

    echo "$mount_point 使用了 $usage_percent%"

    # 若使用率大於等於 80，則發出警告
    if [ "$usage_percent" -ge 80 ]; then
        echo -e "\e[31m⚠️ 警告：$mount_point 使用率已超過 80%！\e[0m"
    fi
done

