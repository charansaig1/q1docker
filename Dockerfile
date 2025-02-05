
# Stage 1: Build stage (installs dependencies & compiles the app)
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /usr/src/app

# Set build arguments
ARG SMS
ARG PORT

# Set environment variables inside the container
ENV SMS=${SMS}
ENV PORT=${PORT}

# Copy package files separately for better caching
COPY package.json package-lock.json ./

# Install production dependencies only to install package log.json
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build 

# Log the SMS environment variable (for verification)
RUN echo "The SMS variable is: ${SMS}" > /usr/src/app/sms.txt

# Stage 2: Production-optimized lightweight image
FROM node:18-alpine 

# Set the working directory
WORKDIR /usr/src/app

# Copy only the necessary built files & dependencies from the builder stage
COPY --from=builder /usr/src/app .

# Expose the port dynamically
EXPOSE ${PORT}

# Run the application
CMD ["npm", "start"]
