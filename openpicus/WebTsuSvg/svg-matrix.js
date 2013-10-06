(function ($) {
    'use strict';
    function Matrix(el, dimension, opt) {
        var defaults = {
            min: 200,
            max: 1023
        },
            svg,
            col,
            row;

        this.el = el;
        this.opt = $.extend({}, defaults, opt);
        this.dimension = dimension;

        console.log('creating SVG');
        this.svg = svg = SVG(el.get(0));
        svg.size('100%', '100%');
        svg.viewbox(0, 0, dimension, dimension);

        this.rects = new Array(dimension);
        for (col = this.dimension - 1; col >= 0; col = col - 1) {
            this.rects[col] = new Array(dimension);
            for (row = this.dimension - 1; row >= 0; row = row - 1) {
                this.rects[col][row] = svg.rect(1,1).move(col, row);
                this.rects[col][row].animate().fill({opacity: 0});
            }
        }
    }

    Matrix.prototype.setData = function (data) {
        var row, col, v;
        for (col = this.dimension - 1; col >= 0; col = col - 1) {
            for (row = this.dimension - 1; row >= 0; row = row - 1) {
                v = Math.max(0, Math.min(this.opt.max, data[col][row]));
                v = (v - this.opt.min) / (this.opt.max - this.opt.min);
                this.rects[col][row].fill({opacity: v});
            }
        }
    }

    $.fn.matrix = function (dimension, opt) {
        var matrix = $(this).data('matrix');
        if (!matrix) {
            matrix = new Matrix(this, dimension, opt);
            $(this).data('matrix', matrix);
        }
        return matrix;
    }
}(jQuery));