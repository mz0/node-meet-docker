FROM node:10-alpine
EXPOSE 3000
RUN rmdir /media/floppy
RUN mkdir /app
WORKDIR /app
ENV NODE_ENV $NODE_ENV
#   supply a volume for /app like this:
# docker run -d -v:somevol:/app <containerID>
#   or bind-mount this dir
# docker run -d -v:.:/app <containerID>
CMD [ "node", "server.js" ]
