ARG DISTRO_VERSION="24.10"
ARG DISTRO="ubuntu"
FROM ${DISTRO}:${DISTRO_VERSION}

# Install Build Tools
RUN apt-get -qq update && \
    DEBIAN_FRONTEND="noninteractive" TZ="Etc/UTC" apt-get -qq -y install \
    build-essential \
    libbz2-dev \
    libonig-dev \
    lintian \
    lsb-release \
    pandoc \
    wget

# Install Minisign
# https://jedisct1.github.io/minisign/
RUN wget -q "https://github.com/jedisct1/minisign/releases/download/0.11/minisign-0.11-linux.tar.gz" && \
    tar -xzf minisign-0.11-linux.tar.gz && \
    mv "minisign-linux/$(uname -m)/minisign" /usr/local/bin && \
    rm -r minisign-linux

# Install zig
# https://ziglang.org/download/
ARG ZIG_VERSION="0.13.0"
RUN wget -q "https://ziglang.org/download/$ZIG_VERSION/zig-linux-$(uname -m)-$ZIG_VERSION.tar.xz" && \
    tar -xf "zig-linux-$(uname -m)-$ZIG_VERSION.tar.xz" -C /opt && \
    rm "zig-linux-$(uname -m)-$ZIG_VERSION.tar.xz" && \
    ln -s "/opt/zig-linux-$(uname -m)-$ZIG_VERSION/zig" /usr/local/bin/zig

# Install Ghostty Dependencies
RUN apt-get -qq update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -qq -y install \
    libadwaita-1-dev \
    libgtk-4-dev
