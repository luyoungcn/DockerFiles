FROM archlinux:latest
MAINTAINER  Evaggelos Balaskas <evaggelos _AT_ balaskas _DOT_ gr>
ENV USER=deploy
ENV PASSWD=deploy
ENV WORKDIR=01-coding

# 替换为USTC镜像，如不需要可以去掉本部分
RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
RUN printf '\n\
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

RUN printf '\n\
[archlinuxcn]\n\
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch' >> /etc/pacman.conf

RUN pacman -Syy
RUN pacman -S --noconfirm archlinuxcn-keyring
RUN pacman -S --noconfirm sudo
RUN pacman -Syyu --noconfirm

# 添加用户并配置密码
RUN useradd -m ${USER} && yes ${PASSWD} | passwd ${USER}

# 赋予sudo权限并允许无密码sudo
RUN echo ${USER}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chmod 644 /etc/sudoers

USER ${USER}
RUN mkdir -p /home/${USER}/${WORKDIR}/

SHELL ["/bin/bash", "-l", "-c"]
