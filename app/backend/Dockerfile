# Use Node.js LTS
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy dependencies
COPY package*.json ./
RUN npm install --production

# Copy app code
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
