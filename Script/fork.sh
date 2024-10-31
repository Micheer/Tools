# 2024-10-31 19:10

#!/bin/bash

# 创建规则目录
mkdir -p Tools/Ruleset/{mihomo/{geosite,geoip},surge/{Block,Media,Other}}

#--- surge ---#
# 广告拦截
# ACL4SSR
curl -L -o Tools-repo/Ruleset/surge/Block/Block_BanAD.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list"
curl -L -o Tools-repo/Ruleset/surge/Block/Block_BanProgramAD.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list"
# MetaCubeX
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Ads.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/category-ads-all.list"
# limbopro
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Adlimbopro.list "https://raw.githubusercontent.com/limbopro/Adblock4limbo/main/Surge/rule/Adblock4limbo_surge.list"
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Privacy.list "https://raw.githubusercontent.com/limbopro/Adblock4limbo/main/rule/Surge/easyprivacy_surge.list"
curl -L -o Tools-repo/Ruleset/surge/Block/Block_EasyListChina.list "https://raw.githubusercontent.com/limbopro/Adblock4limbo/main/rule/Surge/easylistchina_surge.list"
# ConnersHua
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Advertising.list "https://raw.githubusercontent.com/ConnersHua/RuleGo/master/Surge/Ruleset/Extra/Reject/Advertising.list"
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Malicious.list "https://raw.githubusercontent.com/ConnersHua/RuleGo/master/Surge/Ruleset/Extra/Reject/Malicious.list"
curl -L -o Tools-repo/Ruleset/surge/Block/Block_Tracking.list "https://raw.githubusercontent.com/ConnersHua/RuleGo/master/Surge/Ruleset/Extra/Reject/Tracking.list"

# 本地/局域网
curl -L -o Tools-repo/Ruleset/surge/Other/PrivateIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/private.list"

# PayPal
curl -L -o Tools-repo/Ruleset/surge/Other/PayPal.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/paypal.list"

# AI
curl -L -o Tools-repo/Ruleset/surge/Other/Openai.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/openai.list"

# 游戏平台
curl -L -o Tools-repo/Ruleset/surge/Other/Steam.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/steam.list"
curl -L -o Tools-repo/Ruleset/surge/Other/Epic.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/epicgames.list"

# 谷歌平台
curl -L -o Tools-repo/Ruleset/surge/Media/YouTube.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/youtube.list"
curl -L -o Tools-repo/Ruleset/surge/Media/YouTubeMusic.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/YouTubeMusic.list"
curl -L -o Tools-repo/Ruleset/surge/Other/Google.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/google.list"
curl -L -o Tools-repo/Ruleset/surge/Other/GoogleIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/google.list"

# 微软平台
curl -L -o Tools-repo/Ruleset/surge/Other/Line.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/line.list"
curl -L -o Tools-repo/Ruleset/surge/Other/GitHub.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/github.list"
curl -L -o Tools-repo/Ruleset/surge/Other/OneDrive.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/onedrive.list"
curl -L -o Tools-repo/Ruleset/surge/Other/Microsoft.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/microsoft.list"

# 社交平台
curl -L -o Tools-repo/Ruleset/surge/Media/Telegram.list "https://raw.githubusercontent.com/Repcz/Tool/X/Surge/Rules/Telegram.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Twitter.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/twitter.list"
curl -L -o Tools-repo/Ruleset/surge/Media/TwitterIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/twitter.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Facebook.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/facebook.list"
curl -L -o Tools-repo/Ruleset/surge/Media/FacebookIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/facebook.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Instagram.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/instagram.list"

# 影视媒体
curl -L -o Tools-repo/Ruleset/surge/Media/TikTok.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/tiktok.list"
curl -L -o Tools-repo/Ruleset/surge/Media/GlobalMedia.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ProxyMedia.list"
curl -L -o Tools-repo/Ruleset/surge/Media/BilibiliHMT.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/BilibiliHMT.list"
curl -L -o Tools-repo/Ruleset/surge/Media/ChinaMedia.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ChinaMedia.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Bilibili.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/bilibili.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Disney.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/disney.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Netflix.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/netflix.list"
curl -L -o Tools-repo/Ruleset/surge/Media/NetflixIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/netflix.list"
curl -L -o Tools-repo/Ruleset/surge/Media/Spotify.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/spotify.list"

# 海外代理
curl -L -o Tools-repo/Ruleset/surge/Other/GlobalGFW.list "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ProxyGFWlist.list"
curl -L -o Tools-repo/Ruleset/surge/Other/Global.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/geolocation-!cn.list"

# 苹果
curl -L -o Tools-repo/Ruleset/surge/Other/Apple.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/apple.list"

# 国内直连
curl -L -o Tools-repo/Ruleset/surge/Other/China.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/classical/cn.list"
curl -L -o Tools-repo/Ruleset/surge/Other/ChinaIP.list "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/cn.list"
curl -L -o Tools-repo/Ruleset/surge/Other/ChinaASN.list "https://raw.githubusercontent.com/missuo/ASN-China/main/ASN.China.list"



#--- mihomo ---#
# 本地/局域网
curl -L -o Tools/Ruleset/mihomo/geosite/Local.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/private.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/LocalIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/private.mrs"

# ADS
curl -L -o Tools/Ruleset/mihomo/geosite/Ads.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/category-ads-all.mrs"

# AI
curl -L -o Tools/Ruleset/mihomo/geosite/Openai.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/openai.mrs"

# PayPal
curl -L -o Tools/Ruleset/mihomo/geosite/PayPal.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/paypal.mrs"

# 苹果
curl -L -o Tools/Ruleset/mihomo/geosite/Apple.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/apple.mrs"

# 海外代理
curl -L -o Tools/Ruleset/mihomo/geosite/Global.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/geolocation-!cn.mrs"

# 游戏平台
curl -L -o Tools/Ruleset/mihomo/geosite/Steam.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/steam.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Epic.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/epicgames.mrs"

# 影视媒体
curl -L -o Tools/Ruleset/mihomo/geosite/tiktok.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/tiktok.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Bilibili.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/bilibili.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Disney.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/disney.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Netflix.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/netflix.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/NetflixIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/netflix.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Spotify.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/spotify.mrs"

# 社交平台
curl -L -o Tools/Ruleset/mihomo/geosite/Facebook.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/facebook.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/FacebookIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/facebook.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Instagram.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/instagram.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Twitter.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/twitter.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/TwitterIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/twitter.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/telegram.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/telegram.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/telegramIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/telegram.mrs"

# 谷歌平台
curl -L -o Tools/Ruleset/mihomo/geosite/Google.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/google.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/GoogleIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/google.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/YouTube.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/youtube.mrs"

# 微软平台
curl -L -o Tools/Ruleset/mihomo/geosite/Line.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/line.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/GitHub.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/github.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/OneDrive.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/onedrive.mrs"
curl -L -o Tools/Ruleset/mihomo/geosite/Microsoft.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/microsoft.mrs"

# 国内直连
curl -L -o Tools/Ruleset/mihomo/geosite/China.mrs  "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/cn.mrs"
curl -L -o Tools/Ruleset/mihomo/geoip/ChinaIP.mrs "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/cn.mrs"
