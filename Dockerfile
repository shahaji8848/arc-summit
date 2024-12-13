# Stage 1: Build the application
FROM node:22 AS builder

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

# Install project dependencies
RUN npm install --legacy-peer-deps

# Install sharp separately
RUN npm i sharp

# Copy the rest of your application's files to the container
COPY . .

# Install postcss and build the Next.js application
RUN npm install postcss@latest postcss-preset-env@latest && npm run build --no-cache

# Expose the port your Next.js application will run on
EXPOSE 3000

# Bind to 0.0.0.0 to allow access from outside the container.
CMD ["npm", "start"]
