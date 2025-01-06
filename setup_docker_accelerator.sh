#!/bin/bash



sudo mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://docker.m.daocloud.io",
        "https://dockerproxy.com",
        "https://docker.nju.edu.cn",
        "https://docker.mirrors.ustc.edu.cn"
    ]
}
EOF


sudo systemctl daemon-reload

sudo systemctl restart docker
