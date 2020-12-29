FROM node:alpine
WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

CMD ["npm", "run", "start"]

RUN npm run build

FROM nginx
# Tell AWS we need expose port 80, because there is no way we can do docker run 80:80.
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html