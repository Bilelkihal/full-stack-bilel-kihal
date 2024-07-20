# Use Node.js image for development
FROM node:lts-alpine

# Add necessary dependencies for building native modules
RUN apk add --no-cache python3 make g++

# Set working directory
WORKDIR /app

# Copy 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files to the working directory
COPY . .

# Expose the port that Vite will listen on
EXPOSE 5173

# Command to start the Vite development server
CMD ["npm", "run", "dev"]
