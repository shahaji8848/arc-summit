# Stage 1: Build the application
FROM ubuntu:22.04 AS builder

# Set environment variables to run as root
USER root

# Install required dependencies: curl, git, npm, and other packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    npm \
    build-essential \
    python3 \
    python3-pip \
    && apt-get clean

# Install Node.js using nvm (Node Version Manager)
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && source ~/.profile \
    && nvm install 20 \
    && nvm use 20

# Set the working directory in the container
WORKDIR /app

# Clone the arc-summit repository
RUN git clone --branch arc-summit-staging https://github.com/karan1633/arc-summit

# Set the working directory to the themes folder inside arc-summit
WORKDIR /app/arc-summit/themes

# Clone the fancy-gold repository
RUN git clone --branch develop https://github.com/summit-webapp-themes/fancy-gold

# Set the working directory to the fancy-gold theme folder
WORKDIR /app/arc-summit/themes/fancy-gold

# Ensure the theme installation script is executable
RUN chmod +x install-theme.sh

# Run the theme installation script
RUN /bin/bash install-theme.sh

# Change directory back to the root of your project
WORKDIR /app/arc-summit

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install project dependencies with legacy peer dependencies to avoid version conflicts
RUN npm install --legacy-peer-deps

# Install sharp separately
RUN npm i sharp

# Copy the rest of your application's files to the container
COPY . .

# Install build the React.js application
RUN npm install build

# Install PM2 (Process Manager for Node.js)
RUN npm install -g pm2

# Expose the port the React.js application will run on
EXPOSE 3000

# Start the application using PM2 (to run it in the background)
CMD ["pm2", "start", "npm", "--name", "app-name", "--", "start"]
