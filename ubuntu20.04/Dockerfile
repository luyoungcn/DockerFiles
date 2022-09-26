FROM ubuntu:20.04
ENV USER=deploy
ENV PASSWD=deploy
ENV WORKDIR=01-coding

ARG DEBIAN_FRONTEND=noninteractive

# 替换为阿里云镜像，如不需要可以去掉本部分
RUN printf '\n\
deb http://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse \n\
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse \n\
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse \n\
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse \n\
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse \n\
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse \n\
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse \n\
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse \n\
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse \n\
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' > /etc/apt/sources.list

RUN apt-get update \
    && apt-get autoremove -y \
    && apt-get -y upgrade

# Overwrite sh with bash
RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh

# 安装开发环境必要的包
RUN apt-get install -y --fix-broken --fix-missing sudo ssh openssh-server  \
    autoconf automake pkg-config build-essential gcc g++ gdb clang clangd-* \
    gdbserver valgrind make cmake ninja-build gcc-arm-linux-gnueabi gcc-9-arm-linux-gnueabi \
    bison gperf flex bc mtd-utils zlib1g-dev \
    lcov libboost-dev libssl-dev\
    libc6-dev-i386 lib32ncurses5-dev libgl1-mesa-dev dpkg-dev \
    libsdl1.2-dev libxml2-utils libpixman-1-dev libfdt-dev m4 lib32z-dev ccache tofrodos \
    android-sdk-libsparse-utils android-sdk-ext4-utils \
    python3 python3-pip python3-setuptools python python-setuptools \
    python-dev python-simplejson python3-networkx python-numpy \
    man-db manpages-dev manpages-posix-dev \
    graphviz doxygen \
    tar p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract \
    git vim vim-gui-common neovim minicom cscope ctags global silversearcher-ag neofetch rsync gnupg net-tools \
    tmux wget curl weechat \
    #openjdk-8-jdk openjdk-8-jre openjdk-8-doc openjdk-8-jdk-headless openjdk-8-jre-headless \
  && apt-get clean

# Set environmental variable
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

# 添加用户并配置密码
RUN useradd -m ${USER} && yes ${PASSWD} | passwd ${USER}

# 赋予sudo权限并允许无密码sudo
RUN echo ${USER}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chmod 644 /etc/sudoers

RUN if [ ! -e .ssh ]; then mkdir  ~/.ssh; fi \
    && if [ ! -e .ssh/authorized_keys ]; then touch  ~/.ssh/authorized_keys; fi \
    && chmod 600  ~/.ssh/authorized_keys

USER ${USER}
RUN mkdir -p /home/${USER}/${WORKDIR}/
ENV LC_ALL C.UTF-8

SHELL ["/bin/bash", "-l", "-c"]
