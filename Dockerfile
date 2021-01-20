FROM node:14.15.4-buster as builder

ENV NODE_ENV build

USER node
WORKDIR /home/node

COPY . /home/node

RUN npm ci \
    && npm run test:ci \
    && npm run build

# ---

FROM node:14.15.4-buster

ENV NODE_ENV production

USER node
WORKDIR /home/node

COPY --from=builder /home/node/package*.json /home/node/
COPY --from=builder /home/node/dist/ /home/node/dist/
COPY --from=builder /home/node/junit.xml /home/node/junit.xml

RUN npm ci --only=production

CMD ["node", "dist/main"]
