'use strict';

describe('Controller: PmmCtrl', function () {

  // load the controller's module
  beforeEach(module('PressureMatrixMonitorWebApp'));

  var PmmCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    PmmCtrl = $controller('PmmCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
