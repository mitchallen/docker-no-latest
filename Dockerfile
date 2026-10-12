# Use an official Node.js runtime as a parent image
FROM node:24-alpine

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy the rest of the application code to the container
COPY . .

USER node

# Set the container's default command to start the server
CMD ["node", "server.js"]

# Expose port 3000
EXPOSE 3000