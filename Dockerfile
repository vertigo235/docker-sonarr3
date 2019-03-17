FROM hotio/mono

ARG DEBIAN_FRONTEND="noninteractive"

ENV APP="Sonarr3"
EXPOSE 8989
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8989 || exit 1

# install app
# https://download.sonarr.tv/v3/phantom-develop/
RUN VERSION="3.0.1.411" && \
    mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${VERSION}/Sonarr.phantom-develop.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${VERSION}\nPackageAuthor=hotio\nReleaseVersion=${VERSION}\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
