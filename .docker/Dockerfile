# hadolint global ignore=DL3006,DL3008

ARG CURL_IMAGE=curlimages/curl:latest
ARG BUILD_IMAGE


FROM ${CURL_IMAGE} AS download

ARG FFMPEG_VERSION=7.0.2-static
ARG MD5_SUM=7fa72b652e19bf84c9461e332ea1cdf3
ARG PKG_NAME=ffmpeg-release-amd64-static.tar.xz

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]
WORKDIR /tmp

RUN curl -fsSL -O "https://johnvansickle.com/ffmpeg/releases/${PKG_NAME}" \
    && echo "${MD5_SUM}  ${PKG_NAME}" | md5sum -c - \
    && tar xvf "${PKG_NAME}" --strip-components=1 \
    && ./ffmpeg -version | grep -E "${FFMPEG_VERSION}"


FROM ${BUILD_IMAGE} AS build

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        procps \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

COPY --from=download /tmp/ffmpeg /usr/bin/ffmpeg
COPY --from=download /tmp/ffprobe /usr/bin/ffprobe
