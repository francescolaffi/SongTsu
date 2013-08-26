 $(function () {
  var mws = new MatrixWebSocket(8, 100000),
    ws = new WebSocket('ws://127.0.0.1:8080'),
    matrix;
  mws.setWebSocket(ws);
  matrix = $('#matrix').matrix(8);
  mws.on('matrix', function (matrixData) {
    matrix.setData(matrixData);
  });
})