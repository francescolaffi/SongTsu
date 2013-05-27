jQuery(function($) {
    var host = '192.168.1.200:8000';
    var url = 'http://'+host+'/bodyback';

    window.setInterval(requestUpdate, 500);

    function requestUpdate() {
        $.get(url, {cache: false})
            .done(function(data) {
                console.log(data);
                updateGrid(JSON.parse(data));
            })
            .fail(function() {

            })
    }

    function updateGrid(values) {
        for (var i = values.length; i--;) {
            var col = i % 4;
            var row = Math.floor(i / 4);
            var dim = values[i]/1023*100 + 20;
            $('div.point.row-'+row+'.col-'+col).css({width: dim+'px', height: dim+'px'});
        }
    }
});