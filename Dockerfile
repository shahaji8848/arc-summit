# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt update && \
    apt install -y curl git npm

# Install nvm, Node.js 20, and pm2
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    source ~/.profile && \
    nvm install 20 && \
    npm install -g pm2

# Create and navigate to the app directory
RUN mkdir -p /app/arc-summit && \
    cd /app/arc-summit

# Clone the arc-summit repository
RUN git clone --branch arc-summit-staging https://github.com/karan1633/arc-summit /app/arc-summit

# Clone the fancy-gold theme repository
RUN git clone --branch develop https://github.com/summit-webapp-themes/fancy-gold /app/arc-summit/themes/fancy-gold

# Install the theme
RUN chmod +x /app/arc-summit/themes/fancy-gold/install-theme.sh && \
    /app/arc-summit/themes/fancy-gold/install-theme.sh

# Install dependencies for the app
WORKDIR /app/arc-summit
RUN npm install --legacy-peer-deps && \
    npm install sharp

# Build the application
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Start the application using pm2
CMD pm2 start npm --name "summit" -- run start -- --port 3000
