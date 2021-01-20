FROM node:14.15.4-buster

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY . .

CMD ["node", "dist/main"]
