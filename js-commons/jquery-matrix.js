(function ($) {
    function Matrix(dimension, opt) {
        var defaults = {
            min: 0,
            max: 1023,
            setupTableCb: function (table) {
                table.addClass('matrix').width('100%').height('100%');
                table.css({'vertical-align':'middle', 'text-align': 'center', 'border-collapse':'collapse'});
            },
            setupCellCb: function (td) {
                $('<div>').css({'background':'green', 'display':'inline-block'}).appendTo(td);
                td.css('border', '1px solid red');
            },
            setValCb: function (valueNorm) {
                var td = $(this);
                var div = $('div', td);
                div.width(td.width() * valueNorm);
                div.height(td.height() * valueNorm);
            }
        };
        this.opt = $.extend({}, defaults, opt);

        this.dimension = dimension;
        this.table = $('<table>');
        this.opt.setupTableCb(this.table);
        this.cells = new Array(dimension);

        var cellDim = 100 / dimension + '%';
        var td = $('<td>').width(cellDim);
        this.opt.setupCellCb(td);
        var tr = $('<tr>').height(cellDim);
        for (i = dimension - 1; i >= 0; i--) {
            td.clone().appendTo(tr);
        }
        for (i = 0; i < dimension; i++) {
            currTr = tr.clone();
            this.table.append(currTr);
            this.cells[i] = currTr.children().toArray();
        }
    }

    Matrix.prototype.getTable = function () {
        return this.table;
    }

    Matrix.prototype.setData = function (data) {
        for (col = this.dimension - 1; col >= 0; col--) {
            for (row = this.dimension - 1; row >= 0; row--) {
                valueNorm = (data[col][row] - this.opt.min) / (this.opt.max - this.opt.min);
                this.opt.setValCb.call(this.cells[row][col], valueNorm);
            }
        }
    }

    $.fn.matrix = function (dimension, opt) {
        var matrix = $(this).data('matrix');
        if (!matrix) {
            matrix = new Matrix(dimension, opt);
            $(this).append(matrix.getTable());
            $(this).data('matrix', matrix);
        }
        return matrix;
    }
}(jQuery));