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

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER coder

WORKDIR /workspace

EXPOSE 8080

ENTRYPOINT ["/start.sh"]
