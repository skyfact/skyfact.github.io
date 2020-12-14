FROM archlinux/archlinux:latest

RUN pacman -Syu --needed --noconfirm git hugo

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
