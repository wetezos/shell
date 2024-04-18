#!/bin/bash

# 下载node_exporter并解压
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar -xf node_exporter-1.7.0.linux-amd64.tar.gz

# 将node_exporter二进制文件移动到/usr/local/bin/
mv ./node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/

# 清理下载的文件
rm -rf node_exporter-1.7.0.linux-amd64 node_exporter-1.7.0.linux-amd64.tar.gz

# 将配置写入文件
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=node_exporter
After=network.target

[Service]
User=root
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# 启用node_exporter服务
systemctl enable node_exporter

# 重启node_exporter服务
service node_exporter restart

echo "node_exporter安装并配置完成！"
