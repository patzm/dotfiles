FROM alpine:3.11

ARG   BUILD_DATE
ARG   VCS_REF
ARG   BUILD_VERSION

LABEL maintainer="Martin Patz <mailto@martin-patz.de>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="patzm/home" \
      org.label-schema.description="A minimal container environment to feel at home in." \
      org.label-schema.url="https://github.com/patzm/dotfiles" \
      org.label-schema.docker.cmd="docker run --rm -it patzm/$BUILD_VERSION" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.vcs-ref=$VCS_REF

ENV TERM=xterm-256color

COPY . /dotfiles
RUN apk --update \
      add --no-cache --virtual .build-deps \
      ansible build-base python3 git shadow
RUN USER=$(whoami) ./dotfiles/setup --tags packages,dotfiles && \
    apk del .build-deps && \
    rm -r /dotfiles && \
    USER=$(whoami) exec zsh --interactive --login

WORKDIR /root
CMD ["-l"]
ENTRYPOINT ["zsh"]
