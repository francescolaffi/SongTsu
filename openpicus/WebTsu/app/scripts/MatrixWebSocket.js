/**
 * @param dimension number of cols and rows
 * @param timeout ms max delay between cols
 * @constructor
 */
var MatrixWebSocket = (function() {
    'use strict';
    function MatrixWebSocket(dimension, timeout) {
        this.dimension = dimension;
        this.timeout = timeout;
        this.listeners = {};
        this.matrix = new Array(dimension);
        this.lastCol = -1;
        this.lastColTime = 0;

        var self = this;

        this.emit = function (eventType, eventData) {
            if (eventType in self.listeners) {
                self.listeners[eventType].forEach(function (listener) {
                    listener(eventData);
                });
            }
        };
    }

    /**
     * @param eventType string
     * @param listener callback
     */
    MatrixWebSocket.prototype.on = function (eventType, listener) {
        if (!(eventType in this.listeners)) {
            this.listeners[eventType] = [];
        }
        this.listeners[eventType].push(listener);
    };

    MatrixWebSocket.prototype.setWebSocket = function (ws) {
        if (!(ws instanceof WebSocket)) {
            return;
        }

        this.webSocket = ws;

        var self = this;

        ws.onopen = function (event) {
            self.emit('open', event);
        };
        ws.onclose = function (event) {
            self.emit('close', event);
        };
        ws.onerror = function (event) {
            self.emit('error', event);
        };
        ws.onmessage = function (event) {
            var data;
            self.emit('message', event);

            try {
                data = JSON.parse(event.data);
            } catch (err) {
                return;
            }
            // check if valid column message
            if (typeof data !== 'object' || !('c' in data) || !('v' in data) || //check props exist
                  typeof data.c !== 'number' || data.c % 1 || data.c < 0 || data.c >= self.dimension || // check col
                  !Array.isArray(data.v) || data.v.length !== self.dimension) { //check values
                return;
            }

            self.emit('column', data);

            var now = Date.now();

            if ((0 === data.c) || (self.lastCol + 1 === data.c && self.lastColTime + self.timeout >= now)) {
                self.matrix[data.c] = data.v;
                self.lastCol = data.c;
                self.lastColTime = now;

                if (data.c === self.dimension - 1) {
                    self.emit('matrix', self.matrix);
                }
            } else {
                self.lastCol = -1;
            }
        };
    };

    MatrixWebSocket.prototype.getWebSocket = function () {
        return this.webSocket;
    };

    MatrixWebSocket.prototype.connect = function (url) {
        this.setWebSocket(new WebSocket(url));
    };
  
    return MatrixWebSocket;
})();

this.songtsu = {
    MatrixWebSocket: MatrixWebSocket
};

