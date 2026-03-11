#!/bin/bash

# 顯示主機名稱
echo "主機名稱：$(hostname)"

# 抓取記憶體總量與使用量
mem_total=$(free -m | awk '/^Mem:/ {print $2}')
mem_used=$(free -m | awk '/^Mem:/ {print $3}')

# 計算使用率（百分比）
mem_usage=$(echo "scale=2; $mem_used / $mem_total * 100" | bc)

echo "記憶體使用率：$mem_usage%"

# 如果使用率大於 80%，發出警告
if (( $(echo "$mem_usage > 80" | bc -l) )); then
    echo -e "\e[31m⚠️ 警告：記憶體使用率已超過 80%！\e[0m"
fi

