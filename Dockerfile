# Stage 1: Build the application
FROM ubuntu:22.04 AS builder

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && apt-get clean

# Create a user 'ubuntu' with the password 'password'
RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu:password" | chpasswd && adduser ubuntu sudo

# Switch to user 'ubuntu'
USER ubuntu

# Set the working directory in the container
WORKDIR /home/ubuntu/app

# Clone the arc-summit repository
RUN git clone --branch arc-summit-staging https://github.com/karan1633/arc-summit

# Set the working directory to the themes folder inside arc-summit
WORKDIR /home/ubuntu/app/arc-summit/themes

# Clone the fancy-gold repository
RUN git clone --branch develop https://github.com/summit-webapp-themes/fancy-gold

# Set the working directory to the fancy-gold theme folder
WORKDIR /home/ubuntu/app/arc-summit/themes/fancy-gold

# Ensure the theme installation script is executable
RUN chmod +x install-theme.sh

# Run the theme installation script
RUN /bin/bash install-theme.sh

# Change directory back to the root of your project
WORKDIR /home/ubuntu/app/arc-summit

# Install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Install sharp separately
RUN npm install sharp

# Copy the rest of the application files
COPY . .

# Install postcss and build the Next.js application
RUN npm install postcss@latest postcss-preset-env@latest && npm run build --no-cache

# Install PM2 globally
RUN npm install -g pm2

# Expose the port your Next.js application will run on
EXPOSE 3000

# Command to start the application using PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
