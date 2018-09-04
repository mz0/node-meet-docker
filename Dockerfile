FROM node:10-alpine
EXPOSE 3000
VOLUME [/app]
WORKDIR /app
ENV NODE_ENV $NODE_ENV
# bind-mount app dir (with 'server.js') as /app
# and map port to random (or to 3001):
#   docker run -d -v:${PWD}:/app -P (or -p3001:3000)
CMD [ "node", "server.js" ]
