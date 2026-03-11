#!/bin/bash

# 顯示主機名稱
echo "主機名稱：$(hostname)"

# 取得 CPU 使用率
# top -bn1 代表以非互動模式執行一次 top
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); print v }' | awk '{print $NF}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)

# 顯示 CPU 使用率
echo "CPU 使用率：$cpu_usage%"

# 檢查是否超過 90%
if (( $(echo "$cpu_usage > 90" | bc -l) )); then
    echo -e "\e[31m⚠️ 警告：CPU 使用率已超過 90%！\e[0m"
fi

