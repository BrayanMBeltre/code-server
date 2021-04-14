# Start from the code-server Debian base image
FROM codercom/code-server:latest

USER coder

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# Shell: ZSH
RUN apt install -y zsh && \
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install_zsh.sh && \
    chmod +x ./install_zsh.sh && \
    ZSH=~/.zsh && \
    ./install_zsh.sh --unattended && \
    chsh -s /bin/zsh && \
    cd ~/.oh-my-zsh/themes/ && \
    git clone https://github.com/romkatv/powerlevel10k.git && \
    cd ~/.oh-my-zsh/custom/plugins && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    git clone https://github.com/zsh-users/zsh-completions.git && \
    git clone https://github.com/zdharma/history-search-multi-word.git && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git && \
    curl https://raw.githubusercontent.com/DigitalTransformation/vs-code-container-with-ssl/main/config/.zshrc >> ~/.zshrc

# Use bash shell
ENV SHELL=/bin/zsh

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# Copy rclone tasks to /tmp, to potentially be used
COPY deploy-container/rclone-tasks.json /tmp/rclone-tasks.json

# Apply VS Code settings
COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make

# Copy files:
# COPY deploy-container/myTool /home/coder/myTool

# -----------

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
