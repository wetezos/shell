#!/bin/bash

# 下载 Prometheus 和 Node Exporter
wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz
tar -xf prometheus-2.51.2.linux-amd64.tar.gz

# 移动 Node Exporter 到 /usr/local/bin/
mv ./prometheus-2.51.2.linux-amd64/node_exporter /usr/local/bin/

# 删除下载的文件
rm -rf prometheus-2.51.2.linux-amd64 prometheus-2.51.2.linux-amd64.tar.gz

# 写入服务文件
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

# 启用 node_exporter 服务
systemctl enable node_exporter

# 重启 node_exporter 服务
service node_exporter restart
