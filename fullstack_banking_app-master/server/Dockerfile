# Use an official Node.js image as the base
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy only the package.json and package-lock.json first
COPY package*.json ./

# Install app dependencies
RUN npm install

# Now copy the rest of the app's source code
COPY . .

# Expose the port your server will run on
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
