var ws = new WebSocket("ws://localhost:8080");

ws.onmessage = function(e){
  trace(e.data);
};
ws.onclose = function(){
  log("ws closed");
};
ws.onopen = function(){
  log("connected!!");
};

$(function(){
  $("input#post").click(post);
  $("input#message").keydown(function(e){
    if(e.keyCode == 13) post();
  });
});

function post(){
  var name = $("input#name").val();
  var mes = $("input#message").val();
  ws.send(name+" : "+mes);
  $("input#message").val("");
};

function log(message){
  trace("[log] "+message);
};

function trace(message){
  $("#chat").prepend($("<li>").text(message));
};
