FROM archlinux/archlinux:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN pacman -Syu --needed --noconfirm git hugo

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
