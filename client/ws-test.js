var ws = new WebSocket("ws://localhost:8080");
ws.onmessage = function(e){
    trace(e.data);
};
ws.onclose = function(){
    console.log("ws closed");
};
ws.onopen = function(){
    trace('connected!!');
    ws.send('hello server');
};


$(function(){
    $('input#post').click(function(){
        trace('post');
        ws.send($('input#message').val());
    });
});

function trace(message){
    var mes_div = $('<div />').html(message);
    $('div#chat').prepend(mes_div);
};


