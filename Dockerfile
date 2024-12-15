# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Clone the arc-summit repository (adjust path if necessary)
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

# Copy package.json and package-lock.json to the container (this ensures npm install works correctly)
#COPY package*.json ./

# Install project dependencies
RUN npm install --legacy-peer-deps

# Install sharp separately to avoid issues during installation
RUN npm install sharp --no-save

# Copy the rest of your application's files to the container
COPY . .

# Install postcss and build the Next.js application
RUN npm install postcss@latest postcss-preset-env@latest

# Build the Next.js application
RUN npm run build --no-cache

# Expose the port the app runs on
EXPOSE 3038

# Command to run the application
CMD ["npm", "start"]
