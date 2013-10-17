var WebSocket = require('ws');
var redis = require('redis');

client = redis.createClient();

//var ws = new WebSocket('ws://10.0.7.5');
var ws = new WebSocket('ws://127.0.0.1:8080');

ws.on('open', function() {
    //ws.send('something');
    console.log('connect');
});

ws.on('message', function(data, flags) {
    // flags.binary will be set if a binary data is received
    // flags.masked will be set if the data was masked
    //process.stdout.write('< ' + data+"\n");
    var obj = JSON.parse(data);
    //console.log( obj.c );
    // {"c":7,"v":[3,3,3,3,3,3,3,3]}
    //client.set(obj.c, obj.v, redis.print);
    client.set(obj.c, obj.v);
});

//process.stdout.write(client.get("colonna"));
/*client.get("0", function (err, reply) {
    console.log(reply.toString()); // Will print `OK`
});*/
