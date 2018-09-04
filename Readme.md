Node+Docker primer
===========

Try running Node app in Docker

As a rule [Node Dockerfiles](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/))
run 'npm start',
Which in turn [looks for package.json](https://docs.npmjs.com/cli/start)'s

"scripts": { "start": "foo bar.baz" }

and does exactly that, i.e. "foo bar.baz".
Otherwise, if "scripts: {...}" is missing,
'npm start' runs 'node server.js'.

As I do not see any advantage running npm (and occuping some RAM for it), I'll go with 'node server.js'

Building image:
```
docker build -t exactpro/node0:0.1 .
```

Create a container and run it (bind-mount .:/app and run JS from it):
```
NODE_ENV='foobar' docker run -d --env NODE_ENV -p3001:3000 -v ${PWD}:/app --name tempNode1 -h njs0 exactpro/node0:0.1
```

Checking:
```
$ docker ps
CONTAINER ID  IMAGE           COMMAND           CREATED        STATUS        PORTS                   NAMES
51854c3443f2  exactpro/node0  "node server.js"  8 seconds ago  Up 5 seconds  0.0.0.0:3001->3000/tcp  tempNode1
```

Now browse to http://localhost:3001 (e.g. 'curl localhost:3001') and watch something like:
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

Check logs (-f - follow live messages):
```
docker container logs -f tempNode1
```

Shudown app/container (in separate term. session so you can see logs)
```
docker stop tempNode1
```

Note: Pass env. vars (e.g. NODE_ENV) as follows:
-----------------------------------------------
```
  # as usual ('ps e' shows env. vars)
docker run -it --env NODE_ENV='try1' -h njsC1 --name nodejsA1 node:10-alpine /bin/sh
  # pass sensitive info
PASSWORD='foo bar' docker run  [...] -e PASSWORD [...]
  # pass many env. vars in file
docker run --env-file ./env.list
```
