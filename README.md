# ksu-adb-tcp

一个 KernelSU 模块：**开机自动开启 ADB 无线（TCP）调试端口 5555**。

采用 KernelSU 推荐方式实现：脚本放在模块自带的 `service.sh` 里，不向系统或其他目录写入任何文件；卸载即自动移除，无残留。

## 功能

- 每次开机由 KernelSU 在 `late_start service` 阶段自动执行（仅模块启用时）：

```sh
setprop service.adb.tcp.port 5555 && stop adbd && start adbd
```

- 纯 `service.sh` 实现，不写入 `/data/adb/service.d/` 等外部目录；
- 卸载后模块文件由 KernelSU 自动删除，`service.adb.tcp.port` 为运行时属性，重启自动恢复正常；
- 可在 KernelSU 管理器点本模块的【操作】按钮（`action.sh`）立即生效，无需重启。

## 安装

1. 到 [Releases](../../releases) 下载最新的 `adb_tcp_5555.zip`；
2. 用 KernelSU 管理器直接刷入；
3. 重启后自动生效（或在模块上点【操作】按钮立即生效）。

## 验证

```sh
getprop service.adb.tcp.port      # 输出 5555
```

电脑上（手机与电脑同一局域网）：

```sh
adb connect <手机IP>:5555
```

## 文件结构

```
.
├── module.prop     模块信息
├── service.sh      开机自动执行
├── action.sh       可选：管理器【操作】按钮，立即生效（不需要可删除）
└── README.md       本说明
```

## 从源码打包

```sh
zip adb_tcp_5555.zip module.prop service.sh action.sh README.md
```

## 停用 / 卸载

- 停用：模块不再执行，恢复正常状态即可，无需额外操作；
- 卸载：模块文件由 KernelSU 自动删除，无残留。

## 备注

- `service.adb.tcp.port` 是运行时属性，重启会丢失，所以由 `service.sh` 每次开机重新设置；
- adbd 是 init 管理的原生系统服务，不会被 LMK、电池优化等杀掉；若被误操作关闭，点【操作】按钮或重启即可恢复。

## 应用内更新

`module.prop` 已配置 `updateJson`，KernelSU 管理器可直接检测新版本。发布新版本时需要同步修改两处：

- `module.prop`：`version` 和 `versionCode`
- `update.json`：`version`、`versionCode`、`zipUrl`（指向新 Release 的 zip 直链）和 `changelog`

然后用新版本重新打包 zip、打 tag 发 Release 即可。
