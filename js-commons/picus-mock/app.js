var WebSocketServer = require('ws').Server;
var VirtualMatrix = require('../VirtualMatrix.js');

var port = parseInt(process.argv[2]) || 8080;
var freq = parseFloat(process.argv[3]) || 5;
var dim = 8;
var movementDelta = 2;
var pressureDelta = 200;
var colDelay = 1/freq/dim;

var currentCol = 0;
var interval = false;

var matrix = new VirtualMatrix(dim, movementDelta, pressureDelta);

var wss = new WebSocketServer({'port': port});

function doCol () {
    if (0 === wss.clients.length) {
        clearInterval(interval);
        interval = false;
        return;
    }
    if (0 === currentCol) {
        matrix.simulate();
    }
    message = JSON.stringify({c:currentCol,v:matrix.getCol(currentCol)});
    wss.clients.forEach(function(client){
        client.send(message);
    });
    currentCol++;
    currentCol %= dim;
}

wss.on('connection', function(ws) {
    if (!interval) {
        matrix.randomize();
        currentCol = Math.floor(Math.random() * dim);
        interval = setInterval(doCol, colDelay*1000);
    }

    ws.on('message', function(message) {
        console.log('received: %s', message);
    });
});

