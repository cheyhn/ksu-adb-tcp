#!/system/bin/sh
# 在 KernelSU 管理器中点击本模块的【操作】按钮时执行：立即开启 ADB TCP 5555
# （可选文件，不需要可直接删除）
setprop service.adb.tcp.port 5555 && stop adbd && start adbd
echo "ADB TCP 5555 已开启"
