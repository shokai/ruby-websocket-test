var ws = new WebSocket("ws://localhost:9000");

ws.onmessage = function(e){
  trace(e.data);
};
ws.onclose = function(e){
  log("ws closed");
  console.log(e);
};
ws.onopen = function(e){
  log("connected!!");
  console.log(e);
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
  console.log(message);
  trace("[log] "+message);
};

function trace(message){
  $("#chat").prepend($("<li>").text(message));
};
