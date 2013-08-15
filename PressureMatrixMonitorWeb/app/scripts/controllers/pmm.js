'use strict';

angular.module('PressureMatrixMonitorWebApp')
	.controller('PmmCtrl', ['$scope',function (scope) {
		var socket=null;
		scope.server='ws://echo.websocket.org';
		scope.data=[
			{"c":0,"v":[96,3,60,65,118,59,92,29]},
			{"c":1,"v":[82,3,53,55,83,50,66,27]},
			{"c":2,"v":[129,3,66,80,154,67,101,31]},
			{"c":3,"v":[108,3,61,73,131,64,94,30]},
			{"c":4,"v":[130,3,66,79,163,73,105,32]},
			{"c":5,"v":[115,3,61,71,125,66,85,30]},
			{"c":6,"v":[57,3,40,45,60,43,49,25]},
			{"c":7,"v":[68,3,46,52,76,54,61,29]}
		];
		scope.msg='{"c":5,"v":[115,3,61,71,125,66,85,30]}';
		scope.connect=function(){
			scope.disconnect();
			socket=new WebSocket(scope.server);
			socket.onopen=function(){
				console.log('connected to '+scope.server);
				
			};
			socket.onclose=function(){
				console.log('disconnected from '+scope.server);
				
			};
			socket.onerror=function(error){
				console.log('socket error: '+error);
				
			};
			socket.onmessage=function(msg){				
				//console.log('msg: '+msg.data+' from '+scope.server);
				var col = JSON.parse(msg.data);
				scope.data[col.c].v=col.v;									
				scope.$apply();
				//console.log(JSON.stringify(scope.data[col.c]));
				
			};
		};
		scope.disconnect=function(){
			if (socket)
			socket.close();
		};
		scope.send=function(){
			if (socket)
				socket.send(scope.msg);		
		};
	}]);