FROM debian:bullseye

# Installer wget et autres outils nécessaires
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    nano \
    bash \
    && apt-get clean

# Installer Java
RUN wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
RUN dpkg -i jdk-21_linux-x64_bin.deb

# Installer Code-Server
RUN curl -fsSL https://code-server.dev/install.sh | bash && \
    ln -s /usr/lib/code-server/bin/code-server /usr/local/bin/code-server

# Configurer le dossier de travail pour Code-Server
WORKDIR /home/coder/project

# Créer un utilisateur pour Code-Server
RUN useradd -m coder

# Exposer les ports
EXPOSE 25565 8080

# Ajouter un script d'entrée pour lancer Code-Server et Minecraft
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Commande par défaut
CMD ["entrypoint.sh"]