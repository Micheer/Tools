#!/bin/bash
#!name = mihomo 一键脚本
#!desc = 支持，安装、更新、卸载等
#!date = 2024-08-25 10:20
#!author = thNylHx ChatGPT

set -e -o pipefail

# 定义颜色代码
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"

# 定义脚本版本
sh_ver="1.3.1"

# 定义全局变量
FOLDERS="/root/mihomo"
FILE="/root/mihomo/mihomo"
WEB_SERVICES="/root/mihomo/ui"
SYSCTL_CONF="/etc/sysctl.conf"
CONFIG_FILE="/root/mihomo/config.yaml"
VERSION_FILE="/root/mihomo/version.txt"
SYSTEM_FILE="/etc/systemd/system/mihomo.service"

# 获取当前本机 IP 地址
GetLocal_ip(){
    # 获取本机的 IPv4 地址
    ipv4=$(ip addr show $(ip route | grep default | awk '{print $5}') | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    # 获取本机的 IPv6 地址
    ipv6=$(ip addr show $(ip route | grep default | awk '{print $5}') | grep 'inet6 ' | awk '{print $2}' | cut -d/ -f1)
}

# 返回主菜单
Start_Main() {
    echo && echo -n -e "${Red_font_prefix}* 按回车返回主菜单 *${Font_color_suffix}" && read temp
    Main
}

# 检查是否安装
Check_install(){
    if [ ! -f "$FILE" ]; then
        echo -e "${Red_font_prefix}mihomo 未安装${Font_color_suffix}"
        Start_Main
    fi
}

# 检查服务状态
Check_status() {
    if pgrep -x "mihomo" > /dev/null; then
        status="running"
    else
        status="stopped"
    fi
}

# 获取当前安装版本
Get_current_version() {
    if [ -f "$VERSION_FILE" ]; then
        cat "$VERSION_FILE"
    else
        echo "mihomo 未安装"
    fi
}

# 显示当前脚本、是否设置开机自启和服务状态
Show_Status() {
    if [ ! -f "$FILE" ]; then
        status="${Red_font_prefix}未安装${Font_color_suffix}"
        run_status="${Red_font_prefix}未运行${Font_color_suffix}"
        auto_start="${Red_font_prefix}未设置${Font_color_suffix}"
    else
        Check_status
        if [ "$status" == "running" ]; then
            status="${Green_font_prefix}已安装${Font_color_suffix}"
            run_status="${Green_font_prefix}运行中${Font_color_suffix}"
        else
            status="${Green_font_prefix}已安装${Font_color_suffix}"
            run_status="${Red_font_prefix}未运行${Font_color_suffix}"
        fi
        if systemctl is-enabled mihomo.service &>/dev/null; then
            auto_start="${Green_font_prefix}已设置${Font_color_suffix}"
        else
            auto_start="${Red_font_prefix}未设置${Font_color_suffix}"
        fi
    fi
    # 输出状态
    echo -e "脚本版本：${Green_font_prefix}${sh_ver}${Font_color_suffix}"
    echo -e "安装状态：${status}"
    echo -e "运行状态：${run_status}"
    echo -e "开机自启：${auto_start}"
}

# 获取当前架构
Get_the_schema(){
    ARCH_RAW=$(uname -m)
    case "${ARCH_RAW}" in
        'x86_64')    ARCH='amd64';;
        'x86' | 'i686' | 'i386')     ARCH='386';;
        'aarch64' | 'arm64') ARCH='arm64';;
        'armv7l')   ARCH='armv7';;
        's390x')    ARCH='s390x';;
        *)          echo -e "${Red_font_prefix}不支持的架构：${ARCH_RAW}${Font_color_suffix}"; exit 1;;
    esac
}

# 检查和设置 IP 转发参数
check_ip_forward() {
    # 要检查的设置
    local IPV4_FORWARD="net.ipv4.ip_forward = 1"
    # 检查是否已存在 net.ipv4.ip_forward = 1
    if grep -q "^${IPV4_FORWARD}$" "$SYSCTL_CONF"; then
        # 不执行 sysctl -p，因为设置已经存在
        return
    fi
    # 如果设置不存在，则添加并执行 sysctl -p
    echo "$IPV4_FORWARD" >> "$SYSCTL_CONF"
    # 立即生效
    sysctl -p
    echo -e "${Green_font_prefix}IP 转发开启成功${Font_color_suffix}"
}

# 启动
Start() {
    # 检查是否安装
    Check_install
    if systemctl is-active --quiet mihomo; then
        echo -e "${Green_font_prefix}mihomo 正在运行中${Font_color_suffix}"
        Start_Main
    fi
    echo -e "${Green_font_prefix}mihomo 准备启动中${Font_color_suffix}"
    # 重新加载
    systemctl enable mihomo
    # 启动服务
    if systemctl start mihomo; then
        echo -e "${Green_font_prefix}mihomo 启动命令已发出${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}mihomo 启动失败${Font_color_suffix}"
        exit 1
    fi
    # 等待服务启动
    sleep 3s
    # 检查服务状态
    if systemctl is-active --quiet mihomo; then
        echo -e "${Green_font_prefix}mihomo 启动成功${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}mihomo 启动失败${Font_color_suffix}"
        exit 1
    fi
    Start_Main
}

# 停止
Stop() {
    # 检查是否安装
    Check_install
    # 检查是否运行
    if ! systemctl is-active --quiet mihomo; then
        echo -e "${Green_font_prefix}mihomo 已经停止${Font_color_suffix}"
        exit 0
    fi
    echo -e "${Green_font_prefix}mihomo 准备停止中${Font_color_suffix}"
    # 尝试停止服务
    if systemctl stop mihomo; then
        echo -e "${Green_font_prefix}mihomo 停止命令已发出${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}mihomo 停止失败${Font_color_suffix}"
        exit 1
    fi
    # 等待服务启动
    sleep 3s
    # 检查服务状态
    if systemctl is-active --quiet mihomo; then
        echo -e "${Red_font_prefix}mihomo 停止失败${Font_color_suffix}"
        exit 1
    else
        echo -e "${Green_font_prefix}mihomo 停止成功${Font_color_suffix}"
    fi
    Start_Main
}

# 重启
Restart() {
    # 检查是否安装
    Check_install
    echo -e "${Green_font_prefix}mihomo 准备重启中${Font_color_suffix}"
    # 重启服务
    if systemctl restart mihomo; then
        echo -e "${Green_font_prefix}mihomo 重启命令已发出${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}mihomo 重启失败${Font_color_suffix}"
        exit 1
    fi
    # 等待服务启动
    sleep 3s
    # 检查服务状态
    if systemctl is-active --quiet mihomo; then
        echo -e "${Green_font_prefix}mihomo 重启成功${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}mihomo 启动失败${Font_color_suffix}"
        exit 1
    fi
    Start_Main
}

# 卸载
Uninstall() {
    # 检查是否安装
    Check_install
    echo -e "${Green_font_prefix}mihomo 开始卸载${Font_color_suffix}"
    echo -e "${Green_font_prefix}mihomo 卸载命令已发出${Font_color_suffix}"
    # 停止服务
    systemctl stop mihomo.service 2>/dev/null || { echo -e "${Red_font_prefix}停止 mihomo 服务失败${Font_color_suffix}"; exit 1; }
    systemctl disable mihomo.service 2>/dev/null || { echo -e "${Red_font_prefix}禁用 mihomo 服务失败${Font_color_suffix}"; exit 1; }
    # 删除服务文件
    rm -f "$SYSTEM_FILE" || { echo -e "${Red_font_prefix}删除服务文件失败${Font_color_suffix}"; exit 1; }
    # 删除相关文件夹
    rm -rf "$FOLDERS" || { echo -e "${Red_font_prefix}删除相关文件夹失败${Font_color_suffix}"; exit 1; }
    # 重新加载 systemd
    systemctl daemon-reload || { echo -e "${Red_font_prefix}重新加载 systemd 配置失败${Font_color_suffix}"; exit 1; }
    # 等待服务停止
    sleep 3s
    # 检查卸载是否成功
    if [ ! -f "$SYSTEM_FILE" ] && [ ! -d "$FOLDERS" ]; then
        echo -e "${Green_font_prefix}mihomo 卸载完成${Font_color_suffix}"
    else
        echo -e "${Red_font_prefix}卸载过程中出现问题，请手动检查${Font_color_suffix}"
    fi
    exit 0
}

# 更新脚本
Update_Shell() {
    # 获取当前版本
    echo -e "${Green_font_prefix}开始检查是否有更新${Font_color_suffix}"
    # 获取最新版本号
    sh_new_ver=$(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/thNylHx/Tools/main/Script/mihomo-install.sh" | grep 'sh_ver="' | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1)
    # 最新版本无需更新
    if [ "$sh_ver" == "$sh_new_ver" ]; then
        echo -e "当前版本：[ ${Green_font_prefix}${sh_ver}${Font_color_suffix} ]"
        echo -e "最新版本：[ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ]"
        echo -e "${Green_font_prefix}当前已是最新版本，无需更新${Font_color_suffix}"
        Start_Main
    fi
    echo -e "${Green_font_prefix}检查到已有新版本${Font_color_suffix}"
    echo -e "当前版本：[ ${Green_font_prefix}${sh_ver}${Font_color_suffix} ]"
    echo -e "最新版本：[ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ]"
    # 开始更新
    while true; do
        read -p "是否升级到最新版本？(y/n)：" confirm
        case $confirm in
            [Yy]* )
                echo -e "开始下载最新版本 [ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ]"
                wget -O mihomo-install.sh --no-check-certificate https://raw.githubusercontent.com/thNylHx/Tools/main/Script/mihomo-install.sh
                chmod +x mihomo-install.sh
                echo -e "更新完成，当前版本已更新为 ${Green_font_prefix}[ v${sh_new_ver} ]${Font_color_suffix}"
                echo -e "5 秒后执行新脚本"
                sleep 5s
                bash mihomo-install.sh
                break
                ;;
            [Nn]* )
                echo -e "${Red_font_prefix}更新已取消 ${Font_color_suffix}"
                exit 1
                ;;
            * )
                echo -e "${Red_font_prefix}无效的输入，请输入 y 或 n ${Font_color_suffix}"
                ;;
        esac
    done
    Start_Main
}

# 安装
Install() {
    # 检查是否安装 
    if [ -f "$FILE" ]; then
        echo -e "${Green_font_prefix}mihomo 已经安装${Font_color_suffix}"
        Start_Main
    fi
    # 更新系统
    apt update && apt dist-upgrade -y
    # 安装插件
    apt-get install jq unzip curl git wget vim dnsutils openssl coreutils grep gawk iptables gunzip -y
    # 创建文件夹
    mkdir -p $FOLDERS && cd $FOLDERS || { echo -e "${Red_font_prefix}创建或进入 $FOLDERS 目录失败${Font_color_suffix}"; exit 1; }
    # 获取架构
    Get_the_schema
    echo -e "当前架构：[ ${Green_font_prefix}${ARCH_RAW}${Font_color_suffix} ]"
    # 获取版本信息
    VERSION=$(curl -sSL "https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/version.txt" || { echo -e "${Red_font_prefix}获取版本信息失败${Font_color_suffix}"; exit 1; })
    # 构造文件名
    case "$ARCH" in
        'arm64' | 'armv7' | 's390x' | '386') FILENAME="mihomo-linux-${ARCH}-${VERSION}.gz";;
        'amd64') FILENAME="mihomo-linux-${ARCH}-compatible-${VERSION}.gz";;
        *)       echo -e "不支持的架构：[ ${Red_font_prefix}${ARCH}${Font_color_suffix} ]"; exit 1;;
    esac
    # 开始下载
    DOWNLOAD_URL="https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/${FILENAME}"
    echo -e "当前版本：[ ${Green_font_prefix}${VERSION}${Font_color_suffix} ]"
    wget -t 3 -T 30 "${DOWNLOAD_URL}" -O "${FILENAME}" || { echo -e "${Red_font_prefix}下载失败${Font_color_suffix}"; exit 1; }
    echo -e "[ ${Green_font_prefix}${VERSION}${Font_color_suffix} ] 下载完成，开始安装"
    # 解压文件
    gunzip "$FILENAME" || { echo -e "${Red_font_prefix}解压失败${Font_color_suffix}"; exit 1; }
    # 重命名
    if [ -f "mihomo-linux-${ARCH}-${VERSION}" ]; then
        mv "mihomo-linux-${ARCH}-${VERSION}" mihomo
    elif [ -f "mihomo-linux-${ARCH}-compatible-${VERSION}" ]; then
        mv "mihomo-linux-${ARCH}-compatible-${VERSION}" mihomo
    else
        echo -e "${Red_font_prefix}找不到解压后的文件${Font_color_suffix}"
        exit 1
    fi
    # 授权
    chmod 755 mihomo
    # 记录版本信息
    echo "$VERSION" > "$VERSION_FILE"
    # 下载 UI
    echo -e "${Green_font_prefix}开始下载 mihomo 管理面板${Font_color_suffix}"
    git clone https://github.com/metacubex/metacubexd.git -b gh-pages "$WEB_SERVICES"
    # 下载系统配置文件
    echo -e "${Green_font_prefix}开始下载 mihomo 的 Service 系统配置${Font_color_suffix}"
    wget -O "$SYSTEM_FILE" https://raw.githubusercontent.com/thNylHx/Tools/main/Service/mihomo.service && chmod 755 "$SYSTEM_FILE"
    echo -e "${Green_font_prefix}mihomo 安装完成，开始配置${Font_color_suffix}"
    # 开始配置 config 文件
    Configure
}

# 更新
Update() {
    # 检查是否安装
    Check_install
    echo -e "${Green_font_prefix}开始检查是否有更新${Font_color_suffix}"
    cd $FOLDERS
    # 获取当前版本
    CURRENT_VERSION=$(Get_current_version)
    # 获取最新版本
    LATEST_VERSION=$(curl -sSL "https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/version.txt" || { echo -e "${Red_font_prefix}获取版本信息失败${Font_color_suffix}"; exit 1; })
    # 开始更新
    if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
        echo -e "当前版本：[ ${Green_font_prefix}${CURRENT_VERSION}${Font_color_suffix} ]"
        echo -e "最新版本：[ ${Green_font_prefix}${LATEST_VERSION}${Font_color_suffix} ]"
        echo -e "${Green_font_prefix}当前已是最新版本，无需更新${Font_color_suffix}"
        Start_Main
    fi
    echo -e "${Green_font_prefix}检查到已有新版本${Font_color_suffix}"
    echo -e "当前版本：[ ${Green_font_prefix}${CURRENT_VERSION}${Font_color_suffix} ]"
    echo -e "最新版本：[ ${Green_font_prefix}${LATEST_VERSION}${Font_color_suffix} ]"
    while true; do
        read -p "是否升级到最新版本？(y/n)：" confirm
        case $confirm in
            [Yy]* )
                # 获取架构
                Get_the_schema
                # 构造文件名
                case "$ARCH" in
                    'arm64' | 'armv7' | 's390x' | '386') FILENAME="mihomo-linux-${ARCH}-${LATEST_VERSION}.gz";;
                    'amd64') FILENAME="mihomo-linux-${ARCH}-compatible-${LATEST_VERSION}.gz";;
                    *)       FILENAME="mihomo-linux-${ARCH}-compatible-${LATEST_VERSION}.gz";;
                esac
                # 开始下载
                DOWNLOAD_URL="https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/${FILENAME}"
                echo -e "开始下载最新版本：[ ${Green_font_prefix}${LATEST_VERSION}${Font_color_suffix} ]"
                wget -t 3 -T 30 "${DOWNLOAD_URL}" -O "${FILENAME}" || { echo -e "${Red_font_prefix}下载失败${Font_color_suffix}"; exit 1; }
                echo -e "[ ${Green_font_prefix}${LATEST_VERSION}${Font_color_suffix} ] 下载完成，开始更新"
                # 解压文件
                gunzip "$FILENAME" || { echo -e "${Red_font_prefix}解压失败${Font_color_suffix}"; exit 1; }
                # 重命名
                if [ -f "mihomo-linux-${ARCH}-${LATEST_VERSION}" ]; then
                    mv "mihomo-linux-${ARCH}-${LATEST_VERSION}" mihomo
                elif [ -f "mihomo-linux-${ARCH}-compatible-${LATEST_VERSION}" ]; then
                    mv "mihomo-linux-${ARCH}-compatible-${LATEST_VERSION}" mihomo
                else
                    echo -e "${Red_font_prefix}找不到下载后的文件${Font_color_suffix}"
                    exit 1
                fi
                # 授权
                chmod 755 mihomo
                # 更新版本信息
                echo "$LATEST_VERSION" > "$VERSION_FILE"
                # 重新加载 systemd
                systemctl daemon-reload
                # 重启 mihomo 服务
                systemctl restart mihomo
                echo -e "更新完成，当前版本已更新为：[ ${Green_font_prefix}${LATEST_VERSION}${Font_color_suffix} ]"
                # 检查并显示服务状态
                if systemctl is-active --quiet mihomo; then
                    echo -e "当前状态：[ ${Green_font_prefix}运行中${Font_color_suffix} ]"
                else
                    echo -e "当前状态：[ ${Red_font_prefix}未运行${Font_color_suffix} ]"
                    Start_Main
                fi
                Start_Main
                ;;
            [Nn]* )
                echo -e "${Red_font_prefix}更新已取消 ${Font_color_suffix}"
                Start_Main
                ;;
            * )
                echo -e "${Red_font_prefix}无效的输入，请输入 y 或 n ${Font_color_suffix}"
                ;;
        esac
    done
    Start_Main
}

# 配置
Configure() {
    # 检查是否安装
    Check_install
    # 下载配置文件
    CONFIG_URL="https://raw.githubusercontent.com/thNylHx/Tools/main/Config/mihomo/mihomo.yaml"
    curl -s -o "$CONFIG_FILE" "$CONFIG_URL"
    # 获取用户输入的机场数量，默认为 1，且限制为 5 个以内
    while true; do
        read -p "请输入需要配置的机场数量（默认 1 个，最多 5 个）：" airport_count
        airport_count=${airport_count:-1}
        # 验证输入是否为 1 到 5 之间的正整数
        if [[ "$airport_count" =~ ^[0-9]+$ ]] && [ "$airport_count" -ge 1 ] && [ "$airport_count" -le 5 ]; then
            break
        else
            echo -e "\033[31m无效的数量，请输入 1 到 5 之间的正整数。\033[0m"
        fi
    done
    # 读取配置文件
    echo -e "${Green_font_prefix}读取配置文件${Font_color_suffix}"
    # 初始化 proxy-providers 部分
    proxy_providers="proxy-providers:"
    # 动态添加机场
    for ((i=1; i<=airport_count; i++))
    do
        read -p "请输入第 $i 个机场的订阅连接：" airport_url
        read -p "请输入第 $i 个机场的名称：" airport_name
        
        proxy_providers="$proxy_providers
  # 机场$i
  Airport_0$i:
    <<: *pr
    url: \"$airport_url\"
    override:
      additional-prefix: \"[$airport_name]\""
    done
    # 修改配置文件
    echo -e "${Green_font_prefix}修改配置文件${Font_color_suffix}"
    # 写入配置文件
    echo -e "${Green_font_prefix}写入配置文件${Font_color_suffix}"
    # 使用 awk 将 proxy-providers 插入到指定位置
    awk -v providers="$proxy_providers" '
    /^# 机场订阅/ {
        print
        print providers
        next
    }
    { print }
    ' "$CONFIG_FILE" > temp.yaml && mv temp.yaml "$CONFIG_FILE"
    # 验证修改后的配置文件格式
    echo -e "${Green_font_prefix}验证修改后的配置文件格式${Font_color_suffix}"
    # 提示保存位置
    echo -e "${Green_font_prefix}mihomo 配置已完成并保存到 ${CONFIG_FILE} 文件夹${Font_color_suffix}"
    echo -e "${Green_font_prefix}mihomo 配置完成，正在启动中${Font_color_suffix}"
    # 重新加载 systemd
    systemctl daemon-reload
    # 立即启动 mihomo 服务
    systemctl start mihomo
    # # 检查 mihomo 服务状态
    # systemctl status mihomo
    echo -e "${Green_font_prefix}已设置开机自启${Font_color_suffix}"
    # 设置开机启动
    systemctl enable mihomo
    # 调用函数获取
    GetLocal_ip
    # 引导语
    echo -e "恭喜你，你的 mihomo 已经配置完成"
    echo -e "使用 ${Green_font_prefix}http://$ipv4:9090/ui${Font_color_suffix} 访问你的 mihomo 管理面板面板"
    # 返回主菜单
    Start_Main
}

# 主菜单
Main() {
    clear
    echo "================================="
    echo -e "${Green_font_prefix}欢迎使用 mihomo 一键脚本 Beta 版${Font_color_suffix}"
    echo -e "${Green_font_prefix}作者：${Font_color_suffix}${Red_font_prefix}thNylHx${Font_color_suffix}"
    echo -e "${Green_font_prefix}请保证科学上网已经开启${Font_color_suffix}"
    echo -e "${Green_font_prefix}安装过程中可以按 ctrl+c 强制退出${Font_color_suffix}"
    echo "================================="
    echo -e "${Green_font_prefix}0${Font_color_suffix}、更新脚本"
    echo "---------------------------------"
    echo -e "${Green_font_prefix}1${Font_color_suffix}、安装 mihomo"
    echo -e "${Green_font_prefix}2${Font_color_suffix}、更新 mihomo"
    echo -e "${Green_font_prefix}3${Font_color_suffix}、配置 mihomo"
    echo -e "${Green_font_prefix}4${Font_color_suffix}、卸载 mihomo"
    echo "---------------------------------"
    echo -e "${Green_font_prefix}5${Font_color_suffix}、启动 mihomo"
    echo -e "${Green_font_prefix}6${Font_color_suffix}、停止 mihomo"
    echo -e "${Green_font_prefix}7${Font_color_suffix}、重启 mihomo"
    echo -e "${Green_font_prefix}8${Font_color_suffix}、退出脚本"
    echo "================================="
    Show_Status
    echo "================================="
    read -p "请输入选项[0-8]：" num
    case "$num" in
        1) check_ip_forward; Install ;;
        2) Update ;;
        3) Configure ;;
        4) Uninstall ;;
        5) Start ;;
        6) Stop ;;
        7) Restart ;;
        8) exit 0 ;;
        0) Update_Shell ;;
        *) echo -e "${Red_font_prefix}无效选项，请重新选择${Font_color_suffix}" 
           exit 1 ;;
    esac
}

# 启动主菜单
Main
