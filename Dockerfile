FROM node:16.14-alpine

WORKDIR /app-backend

COPY . .
ENV APP_PORT=3001
ENV JWT_SECRET=jwt_secret
ENV DB_USER=postgres
ENV DB_PASS=123456
ENV DB_HOST=localhost
ENV DB_PORT=5432
RUN npm install
EXPOSE 3001
CMD ["npm", "start"]
