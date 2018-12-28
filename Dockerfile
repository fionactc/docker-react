FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Does nothing on development, but Elasticbeanstalk will look for EXPOSE setting
# Map automatically for incoming traffic
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
