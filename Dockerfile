# dockerfile
# build stage1
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
VOLUME ["/usr/share/nginx/html"]
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["docker","volume","list;","nginx", "-g", "daemon off;"]
