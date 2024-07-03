FROM node:alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Clean cache and remove node_modules and package-lock.json if they exist
RUN npm cache clean --force && rm -rf node_modules package-lock.json

# Install project dependencies, including serve for serving static files
RUN npm install && npm install -g json-server serve

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Expose the necessary ports
EXPOSE 3000 4000

# CMD to start json-server and serve the main application
CMD ["sh", "-c", "json-server api/db.json --port 4000 & serve -s build -l 3000"]
# CMD ["sh", "-c", "npm run api & serve -s build -l 3000"]



# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' keeptrack-app

# docker run -dp 8000:3000 -p 4000:4000 --name keeptrack-app keeptrack-applatest
