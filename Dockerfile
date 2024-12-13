# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt update && \
    apt install -y curl git npm bash

# Install nvm and Node.js version 20
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 20 && \
    nvm use 20 && \
    # Remove existing node and npm binaries if they exist
    rm -f /usr/bin/node /usr/bin/npm && \
    ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" /usr/bin/node && \
    ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" /usr/bin/npm

# Verify Node.js and npm versions
RUN node -v && npm -v

# Create and navigate to the app directory
RUN mkdir -p /app/arc-summit && \
    cd /app/arc-summit

# Clone the arc-summit repository
RUN git clone --branch arc-summit-staging https://github.com/karan1633/arc-summit /app/arc-summit

# Clone the fancy-gold theme repository
RUN git clone --branch develop https://github.com/summit-webapp-themes/fancy-gold /app/arc-summit/themes/fancy-gold

# Make the install-theme.sh script executable
RUN chmod +x /app/arc-summit/themes/fancy-gold/install-theme.sh

# Suppress errors for missing files during theme installation
RUN /app/arc-summit/themes/fancy-gold/install-theme.sh || echo "Some files are missing, skipping those steps."

# Change directory back to the root of your project
WORKDIR /app/arc-summit

# Clean npm cache and delete internal npm directories
#RUN npm cache clean --force || true && npm install --legacy-peer-deps || true && npm install sharp || true
RUN npm cache clean --force && npm install
# Copy the rest of your application's files to the container
COPY . .

# Build the application
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Start the application using pm2
CMD pm2 start npm --name "summit" -- run start -- --port 3000
