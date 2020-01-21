FROM alpine:3.11

ENV TERM=xterm-256color
COPY . /dotfiles
RUN apk --update add ansible build-base python3 git && \
    USER=$(whoami) ansible-playbook /dotfiles/setup.yml && \
    apk del ansible build-base && \
    rm -r /dotfiles && \
    USER=$(whoami) exec zsh --interactive --login

WORKDIR /root
CMD ["-l"]
ENTRYPOINT ["zsh"]
