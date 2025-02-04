
# Step 1: Use the official Node.js image from the Docker Hub
FROM node:16


WORKDIR /usr/src/app

# Step 3: Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# Step 4: Install the Node.js dependencies
RUN npm install

# Copy the rest of the source files into the image.
COPY . .


# Use a default port if PORT is not set.
ENV PORT=${PORT:-3000}

# Expose the port that the application listens on.

EXPOSE ${PORT}
# Run the application.
CMD ["node", "index.js"]
