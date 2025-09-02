# Sing-box 配置说明

## 当前状态

配置文件 `sub-config.json` 已经修复了语法错误，所有outbound的缺失标签问题都已解决。

## 需要完成的工作

### 1. 添加实际节点配置

当前配置使用了占位符节点标签（如"香港节点1", "香港节点2"等），您需要添加实际的节点配置。在outbounds数组中添加类似以下配置：

```json
{
  "tag": "香港节点1",
  "type": "vmess",
  "server": "hk-server.example.com",
  "server_port": 443,
  "uuid": "your-uuid-here",
  "security": "auto",
  "alter_id": 0,
  "transport": {
    "type": "ws",
    "path": "/path",
    "headers": {
      "Host": "hk-server.example.com"
    }
  }
}
```

### 2. 支持的节点类型

您可以根据需要添加以下类型的节点：
- `vmess` - VMess协议
- `vless` - VLESS协议  
- `trojan` - Trojan协议
- `shadowsocks` - Shadowsocks协议
- `hysteria` - Hysteria协议
- `hysteria2` - Hysteria2协议

### 3. 配置示例

```json
// VMess 示例
{
  "tag": "香港优质节点",
  "type": "vmess",
  "server": "hk.example.com",
  "server_port": 443,
  "uuid": "12345678-1234-1234-1234-123456789012",
  "security": "auto",
  "alter_id": 0,
  "transport": {
    "type": "ws",
    "path": "/v2ray",
    "headers": {
      "Host": "hk.example.com"
    }
  }
}

// Trojan 示例
{
  "tag": "日本高速节点",
  "type": "trojan",
  "server": "jp.example.com",
  "server_port": 443,
  "password": "your-password-here",
  "transport": {
    "type": "ws",
    "path": "/trojan",
    "headers": {
      "Host": "jp.example.com"
    }
  }
}
```

### 4. 使用说明

1. 添加实际节点配置到outbounds数组中
2. 确保节点标签与selector/urltest中使用的标签匹配
3. 运行 `sing-box check -c sub-config.json` 验证配置
4. 启动服务：`sing-box run -c sub-config.json`

### 5. 故障排除

如果遇到问题，检查：
- 所有标签引用是否正确
- 节点服务器地址和端口是否正确
- 认证信息（UUID、密码等）是否正确
- 传输配置是否正确
