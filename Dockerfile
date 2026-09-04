FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Update Ubuntu + install a broad set of common tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    apt-utils \
    sudo \
    systemd \
    systemd-sysv \
    dbus \
    dbus-user-session \
    bash \
    bash-completion \
    coreutils \
    util-linux \
    procps \
    iproute2 \
    iputils-ping \
    net-tools \
    dnsutils \
    traceroute \
    telnet \
    openssh-client \
    openssh-server \
    git \
    git-lfs \
    curl \
    wget \
    aria2 \
    rsync \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz-utils \
    nano \
    vim \
    neovim \
    less \
    htop \
    btop \
    tree \
    file \
    lsof \
    psmisc \
    jq \
    ca-certificates \
    gnupg \
    software-properties-common \
    apt-transport-https \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    python-is-python3 \
    nodejs \
    npm \
    default-jre \
    default-jdk \
    perl \
    ruby \
    golang \
    rustc \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create workspace
RUN mkdir -p /workspace && \
    chmod 777 /workspace

# Create normal user
RUN useradd -m -s /bin/bash coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder && \
    chmod 0440 /etc/sudoers.d/coder && \
    chown -R coder:coder /workspace

# Give coder a useful shell
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/coder/.bashrc && \
    echo 'alias ll="ls -lah"' >> /home/coder/.bashrc && \
    echo 'alias la="ls -A"' >> /home/coder/.bashrc

COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /workspace

USER coder

EXPOSE 8080

ENTRYPOINT ["/start.sh"]
