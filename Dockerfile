FROM codercom/code-server:latest

USER root

# Install useful tools
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

# Create workspace
RUN mkdir -p /workspace && \
    chown -R coder:coder /workspace

# Railway uses PORT automatically
ENV PASSWORD=change-me
ENV PORT=8080

USER coder

WORKDIR /workspace

EXPOSE 8080

CMD ["sh", "-c", "code-server --bind-addr 0.0.0.0:${PORT} --auth password /workspace"]
