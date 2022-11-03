FROM node  AS builder

WORKDIR /app

# Installing dependencies
COPY ./package.json .
RUN npm install

COPY . .

# Starting our application
RUN npm run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/build .

CMD ["nginx","-g","daemon off;"]