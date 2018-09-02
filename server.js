var http = require('http');

const PORT = 3000;

function requestHandler(req, res) {
	res.end(`<pre>\n Platform: ${process.platform}\n Versions:\n` + versions() + "\n</pre>");
}

function versions() {
	o = process.versions;
	oStr = '';
	Object.keys(o).forEach((key)=> oStr+=`${key} : ${o[key]}\n`);
	return oStr;
}

var server = http.createServer(requestHandler);

server.listen(PORT, function(){
	console.log(`${process.env.NODE_ENV} server listening on port: ${PORT}. CTRL-C to exit.`);
});

process.on('SIGTERM', () => {
  console.info('SIGTERM signal received.');
  server.close(() => {
    console.log('HTTP server closed.');
  });
});
