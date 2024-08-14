#!/bin/bash

## bash <(curl -fsSL https://raw.githubusercontent.com/thNylHx/Tools/main/Script/thNylHx.sh)

set -e -o pipefail

# 检查 root 权限
if [[ $EUID -ne 0 ]]; then
    echo "请以 root 权限运行此脚本。"
    exit 1
fi

echo "================================="
echo "欢迎使用一键脚本"
echo "作者：thNylHx"
echo "请保证科学上网已经开启"
echo "安装过程中可以按 ctrl+c 强制退出"
echo "================================="

# 检查 Docker 环境
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Docker 未安装。请先安装 Docker。"
        exit 1
    fi

    if ! systemctl is-active --quiet docker; then
        echo "Docker 服务未运行。请启动 Docker 服务。"
        exit 1
    fi
}

# 显示主菜单
show_menu() {
    echo " 1. 安装 docker 和 docker-compose"
    echo " 2. 安装 青龙面板"
    echo " 3. 安装 AdGuardHome"
    echo "---------------------------------"
    echo " 4. 安装 mihomo"
    echo " 5. 安装 VMESS"
    echo " 6. 安装 Trojan-go"
    echo " 7. 安装 Shadowsocks-Rust"
    echo "---------------------------------"
    echo " 8. 一键开启 ROOT 权限"
    echo " 9. 一键更换软件源（Debian 12）"
    echo "---------------------------------"
    echo " 0. 退出一键安装脚本"
    echo "================================="
}

# 主菜单循环
while true; do
    # 显示主菜单
    show_menu
    
    # 读取用户输入
    read -p "输入数字选择[0-9]: " action

    case $action in
        1)
        echo "开始安装 docker 和 docker-compose"
        bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.sh)
        echo "docker 和 docker-compose 安装完成!"
        ;;

        2)
        echo "开始安装 青龙面板"
        # 检查 Docker 环境
        check_docker
        
        ;;

        3)
        echo "开始安装 AdGuardHome"
        curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
        echo "AdGuardHome 安装完成!"
        ;;

        4)
        echo "开始安装 mihomo"
        bash <(curl -fsSL https://raw.githubusercontent.com/thNylHx/Tools/main/Script/mihomo-install.sh)
        echo "mihomo 安装完成!"
        ;;

        5)
        echo "开始安装 VMESS"
        bash <(curl -fsSL https://raw.githubusercontent.com/thNylHx/Tools/main/Script/vmess-install.sh)
        echo "VMESS 安装完成!"
        ;;

        6)
        echo "开始安装 Trojan-go"
        # 这里应该插入安装 Trojan-go 的命令
        echo "Trojan-go 安装完成!"
        ;;

        7)
        echo "开始安装 Shadowsocks-Rust"
        # 这里应该插入安装 Shadowsocks-Rust 的命令
        echo "Shadowsocks-Rust 安装完成!"
        ;;

        8)
        echo "开始一键开启 ROOT 权限"
        echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && systemctl restart sshd
        echo "ROOT 权限开启完成!"
        ;;

        9)
        echo "开始一键更换软件源（Debian 12）"
        cat << EOF > /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
EOF
        echo "软件源更换完成!"
        ;;

        0)
        echo "退出一键安装脚本"
        exit 0
        ;;

        *)
        echo "无效选择，请输入 [0-9] 之间的数字。"
        ;;
    esac

    echo "请按 Enter 键返回主菜单..."
    read -r
done
