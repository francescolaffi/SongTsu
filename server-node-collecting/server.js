#!/usr/bin/env node

var redis = require('redis');
rclient = redis.createClient();

var WebSocket = require('ws');
var WebSocketServer = WebSocket.Server
var wss = new WebSocketServer({port: 9000});

var freq = 5;
var colDelay = 1/freq/dim;

var dim = 8;
var currentCol = 0;
var interval = false;

function doCol () {
    if (0 === wss.clients.length) {
        clearInterval(interval);
        interval = false;
        return;
    }
    
    wss.clients.forEach(function(client){
        var fixCol = currentCol;
		rclient.get(fixCol, function (err, reply) {
            reply_obj = JSON.parse(reply)
		    message = JSON.stringify({c:fixCol,v:reply_obj});
            try {
			 client.send(message);    
            } catch(e){
                console.log("problema invio");
            }
		});
        
    });
    currentCol++;
    currentCol %= dim;
}

wss.on('connection', function(ws) {
    if (!interval) {
        currentCol = Math.floor(Math.random() * dim);
        interval = setInterval(doCol, colDelay*1000);
    }

    ws.on('message', function(message) {
        console.log('received: %s', message);
    });
});


wss.on('close', function(ws) {
    console.log('close')
});