// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require ckeditor-jquery
//= require bootstrap
//= require activestorage
//= require adminlte
//= require select2.min
//= require turbolinks
//= require_tree .


$(document).ready(function(){

  // const checkRating = () => {
  //   fetch("http://127.0.0.1:4042/groups/send_notification")
  //     .then(response => response.text())
  //     .then(response => {
  //       debugger;
  //       // document.getElementById("rating").innerHTML = response;
  //     });
  // };
  //
  // setInterval(checkRating, 20000);

});

function playSound(){
  var mp3Source = '<source src="' + "/piece-of-cake" + '.mp3" type="audio/mpeg">';
  document.getElementById("sound").innerHTML='<audio autoplay="autoplay">' + mp3Source  + '</audio>';
}

function appendData(ticket) {
  console.log("hello");
  var badge;
  var url = `<a href="tickets/${ticket.id}">`;
  if(ticket.priority == "1 low"){
  badge = '<span class="badge bg-warning">low</span>';
} else if(ticket.priority == "2 normal"){
  badge = '<span class="badge bg-primary">normal</span>';
} else if(ticket.priority == "3 high"){
  badge = '<span class="badge bg-danger">high</span>';
}
  var content = '<tr>'+
    '<td>'+ticket.number+'</td>'+
    '<td>'+ticket.title+'</td>'+
    '<td>'+ticket.customer+'</td>'+
    '<td>'+ticket.created_at+'</td>'+
    '<td>'+
    badge+
    '</td>'+
    '<td>'+
      '<span class="badge bg-danger">NEW</span>'+
      '</td>'+
      '<td>'+
      url+
      '<span class="float-right text-sm text-primary">'+
      '<i class="fa fa-eye">'+
      '</i>'+
      '</span>'+
      '</a>'+
      '</td>'+
  '</tr>';
  // debugger;
$('#ticket').append(content);
}
