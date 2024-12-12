# Use lightweight Ubuntu 22.04 as the base image
FROM ubuntu:22.04 AS builder

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required tools for building
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    build-essential \
    python3 \
    sudo \
    lsb-release \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js v20 (with lsb-release to resolve potential issues)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Verify Node.js and npm versions
RUN node -v && npm -v

# Create a user 'ubuntu' with the password 'password'
RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu:password" | chpasswd && adduser ubuntu sudo

# Set the working directory in the container
WORKDIR /home/ubuntu/app

# Switch to user 'ubuntu'
USER ubuntu

# Clone the arc-summit repository
RUN git clone --branch arc-summit-staging https://github.com/karan1633/arc-summit.git arc-summit

# Set the working directory to the themes folder inside arc-summit
WORKDIR /home/ubuntu/app/arc-summit/themes

# Clone the fancy-gold repository
RUN git clone --branch develop https://github.com/summit-webapp-themes/fancy-gold.git fancy-gold

# Set the working directory to the fancy-gold theme folder
WORKDIR /home/ubuntu/app/arc-summit/themes/fancy-gold

# Ensure the theme installation script is executable
RUN chmod +x install-theme.sh

# Run the theme installation script
RUN /bin/bash install-theme.sh

# Return to the project root directory
WORKDIR /home/ubuntu/app/arc-summit

# Copy package.json and package-lock.json first to leverage Docker caching
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Install sharp separately (if required for your project)
RUN npm install sharp

# Copy the rest of the application files
COPY . .

# Build the React.js application
RUN npm run build

# Install PM2 globally
RUN npm install -g pm2

# Expose the port your React application will run on
EXPOSE 3000

# Start the application using PM2 with a custom process name and port
CMD ["pm2-runtime", "start", "npm", "--name", "arc-summit", "--", "run", "start"]
