# Use an official Node.js runtime as a parent image
# Floating LTS tag: tracks the current Node LTS line automatically and, being
# non-numeric, never triggers a Dependabot major-version PR (which would
# propose odd or pre-LTS releases).
FROM node:lts-alpine

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