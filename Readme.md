Node primer
===========

My first try of dockerized Node app

As a rule [Node Dockerfiles](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)) run 'npm start',
Which in turn [looks for package.json](https://docs.npmjs.com/cli/start)'s

"scripts": { "start": "foo bar.baz" }

and does exactly that, i.e. "foo bar.baz".
Otherwise, if "scripts: {...}" is missing,
'npm start' runs 'node server.js'.

However [in containers npm may start node from shell](https://medium.com/@becintec/building-graceful-node-applications-in-docker-4d2cd4d5d392)
thus isolating it from SIGTERM.
To stay on the safe side I call *node* without npm, hence *CMD [ "node", "server.js" ]*.

Building image:
```
docker build -t exactpro/node0:0.1 .
```

Running (bind-mount .:/app and run this thing from it):
```
NODE_ENV='foobar' docker run -d --env NODE_ENV -p3001:3000 -v ${PWD}:/app --name tempNode1 -h njs0 exactpro/node0
```

Checking:
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
51854c3443f2        exactpro/node0      "node server.js"    8 seconds ago       Up 5 seconds        0.0.0.0:3001->3000/tcp   tempNode1
```

Now browse to http://localhost:3001 and watch something like:
```
 Platform: linux
 Versions:
http_parser : 2.8.0
node : 10.9.0
v8 : 6.8.275.24-node.14
uv : 1.22.0
zlib : 1.2.11
ares : 1.14.0
modules : 64
nghttp2 : 1.32.0
napi : 3
openssl : 1.1.0i
icu : 62.1
unicode : 11.0
cldr : 33.1
tz : 2018e
```

Note: Pass env. vars (e.g. NODE_ENV) as follows:
-----------------------------------------------
```
docker run -it --env NODE_ENV='try1' -h njsC1 --name nodejsA1 node:10-alpine /bin/sh
  # pass sensitive info
PASSWORD='foo bar' docker run  [...] -e PASSWORD [...]
  # pass many env. vars in file
docker run --env-file ./env.list
```

To make it clear: package.json is not used here (as soon as we do not rely on 'npm start'), neither is env.list
