# Use Ubuntu as the base image
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    clang \
    clang-format \
    clang-tidy \
    cmake \
    git \
    lldb \
    make \
    ninja-build \
    pkg-config \
    python3 \
    python3-pip \
    wget \
    zsh \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user (optional, but recommended for security)
RUN useradd -m dev
RUN chsh -s $(which zsh) dev

USER dev

# Use zsh-in-docker https://github.com/deluan/zsh-in-docker
# Default powerline10k theme, no plugins installed
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" \
    -x \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p 'history-substring-search' \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'


# Set the default command to zsh
CMD ["/bin/zsh"] 

WORKDIR /workspaces