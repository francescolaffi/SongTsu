'use strict';

angular.module('PressureMatrixMonitorWebApp', [])
  .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/pmmView.html',
        controller: 'PmmCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }]);
