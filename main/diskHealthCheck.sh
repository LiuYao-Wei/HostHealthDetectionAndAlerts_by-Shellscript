#!/bin/bash

echo "===== 硬碟健康檢查 ====="
echo "主機名稱：$(hostname)"
echo "檢查時間：$(date)"
echo "-------------------------"

# 取得所有 sd* 裝置（不包含分割區）
for disk in $(lsblk -dno NAME); do
    echo "裝置：/dev/$disk"
    status=$(sudo smartctl -H /dev/$disk | grep "SMART Health Status" | awk '{print $4}')
    
    if [ "$status" = "OK" ]; then
        echo -e "✅ 健康狀態：\e[32m$status\e[0m"
    else
        echo -e "⚠ 健康狀態：\e[31m$status\e[33m（請檢查！）\e[0m"
    fi

    echo "-------------------------"
done

