# Use an official Node.js runtime as a parent image
FROM node:16

# Set build arguments
ARG SMS
ARG PORT

# Set environment variables inside the container
ENV SMS=${SMS}
ENV PORT=${PORT}

# Set the working directory
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port dynamically
EXPOSE ${PORT}

# Log the SMS environment variable (for verification)
RUN echo "The SMS variable is: ${SMS}" > /usr/src/app/sms.txt

# Run the application
CMD ["npm", "start"]
