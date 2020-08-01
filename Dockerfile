# production stage
FROM nginx:stable-alpine as production-stage
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
WORKDIR /sources
COPY . .

# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --prod

FROM production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
