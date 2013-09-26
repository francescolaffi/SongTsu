(function () {
    /**
     * @param dimension number of cols and rows
     * @param movementDelta max +/- variation in matrix positions
     * @param pressureDelta max +/- variation in pressure
     * @constructor
     */
    function VirtualMatrix(dimension, movementDelta, pressureDelta) {
        this.dimension = dimension;
        this.movementDelta = movementDelta;
        this.pressureDelta = pressureDelta;

        this.matrix = new Array(dimension);
        for (i = dimension - 1; i >= 0; i--) {
            this.matrix[i] = new Array(dimension);
        }
        this.pressureCol = 0;
        this.pressureRow = 0;
        this.pressureValue = 0;

        var self = this;

        this.calcMatrix = function () {
            for (col = self.dimension-1; col >= 0; col--) {
                for (row = self.dimension-1; row >= 0; row--) {
                    colDistanceMult = Math.max(0, 1-Math.abs(col+0.5-self.pressureCol));
                    rowDistanceMult = Math.max(0, 1-Math.abs(row+0.5-self.pressureRow));
                    self.matrix[col][row] = Math.round(colDistanceMult * rowDistanceMult * this.pressureValue);
                }
            }
        }
    }

    var p = VirtualMatrix.prototype;

    /**
     * @param col column index
     * @returns array values
     */
    p.getCol = function (col) {
        return this.matrix[col];
    }

    /**
     * randomize position and pressure
     */
    p.randomize = function () {
        this.pressureCol = Math.random() * this.dimension;
        this.pressureRow = Math.random() * this.dimension;
        this.pressureValue = Math.floor(Math.random() * 1024);
        this.calcMatrix();
    }

    p.simulate = function () {
        this.pressureCol = randConstrained(this.pressureCol, this.movementDelta, 0, this.dimension);
        this.pressureRow = randConstrained(this.pressureRow, this.movementDelta, 0, this.dimension);
        this.pressureValue = Math.floor(randConstrained(this.pressureValue, this.pressureDelta, 0, 1023));
        this.calcMatrix();
    }

    function randConstrained (current, delta, min, max) {
        value = current + (Math.random()*2-1) * delta;
        return Math.min(Math.max(value, min), max);
    }

    if (module.exports !== undefined) {
        module.exports = VirtualMatrix;
    } else {
        window.VirtualMatrix = VirtualMatrix;
    }
}());