FROM codercom/code-server:latest

USER root

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    zip \
    nano \
    vim \
    htop \
    sudo \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace && chown -R coder:coder /workspace

USER coder

WORKDIR /workspace

EXPOSE 8080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["--bind-addr", "0.0.0.0:8080", "--auth", "password", "/workspace"]
