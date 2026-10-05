#!/system/bin/sh
# ============================================================
#  ADB TCP 5555  (KernelSU 模块)
#  由 KernelSU 在每次开机 late_start service 阶段执行（仅模块启用时）
# ============================================================
setprop service.adb.tcp.port 5555 && stop adbd && start adbd
