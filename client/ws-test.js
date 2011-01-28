var ws = new WebSocket("ws://localhost:8080");
ws.onmessage = function(e){
    trace(e.data);
};
ws.onclose = function(){
    log("ws closed");
};
ws.onopen = function(){
    log('connected!!');
};

$(function(){
    $('input#post').click(function(){
        var name = $('input#name').val();
        var mes = $('input#message').val();
        ws.send(name+" : "+mes);
        $('input#message').val("");
    });
});

function log(message){
    trace("[log] "+message);
};

function trace(message){
    var mes_div = $('<div />').html(message);
    $('div#chat').prepend(mes_div);
};


