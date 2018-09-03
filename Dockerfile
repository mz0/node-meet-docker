FROM node:10-alpine
EXPOSE 3000
RUN mkdir /app
WORKDIR /app
ENV NODE_ENV $NODE_ENV
# bind-mount app dir (with 'server.js') as /app
# and map port to random (or to e.g. 3001):
#   docker run -d -v:.:/app -P (or -p3001:3000)
CMD [ "node", "server.js" ]
