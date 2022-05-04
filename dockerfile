FROM node:16.15.0-alpine as build
WORKDIR /app
COPY . /app/

RUN npm install
RUN npm run build

FROM nginx
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80
CMD ["nginx", "-g", "demon off;"]

