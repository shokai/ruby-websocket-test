var ws = new WebSocket("ws://localhost:8080");
var KC = {tab:9, enter:13, left:37, up:38, right:39, down:40};

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
    $('input#post').click(post);
    $('input#message').keydown(function(e){
        if(e.keyCode == KC.enter){
            post();
        }
    });
});

function post(){
    var name = $('input#name').val();
    var mes = $('input#message').val();
    ws.send(name+" : "+mes);
    $('input#message').val("");    
};

function log(message){
    trace("[log] "+message);
};

function trace(message){
    var mes_div = $('<div />').html(message);
    $('div#chat').prepend(mes_div);
};


