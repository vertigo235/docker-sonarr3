FROM hotio/mono

ARG DEBIAN_FRONTEND="noninteractive"

ENV APP="Sonarr3"
EXPOSE 8989
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8989 || exit 1

# install app
# https://download.sonarr.tv/v3/phantom/
# https://download.sonarr.tv/v3/phantom-develop/
RUN curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/3.0.1.376/Sonarr.phantom-develop.3.0.1.376.linux.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
