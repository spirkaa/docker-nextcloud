# hadolint global ignore=DL3006,DL3008

ARG CURL_IMAGE=curlimages/curl:latest
ARG BUILD_IMAGE


FROM ${CURL_IMAGE} AS download

ARG PKG_REF=autobuild-2026-11-20-12-40
ARG PKG_NAME=ffmpeg-n9.0.2-61-gd59078794d-linux64-gpl-9.0.tar.xz
ARG SHA256_SUM=080e804801eac92399a98687575b64aa38e557ed651cc381dfbc1e8fe5c2ccd8

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]
WORKDIR /tmp

RUN curl -fsSL -O "https://github.com/FFmpeg-Builds/FFmpeg-Builds/releases/download/${PKG_REF}/${PKG_NAME}" \
    && echo "${SHA256_SUM}  ${PKG_NAME}" | sha256sum -c - \
    && tar xvf "${PKG_NAME}" --strip-components=1


FROM ${BUILD_IMAGE} AS build

ARG FFMPEG_VERSION=9.0.2-61-gd59078794d

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        procps \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

COPY --from=download /tmp/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=download /tmp/bin/ffprobe /usr/bin/ffprobe

RUN ffmpeg -version | grep -E "^ffmpeg version n${FFMPEG_VERSION}-"
