// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {
  $('.datepicker').datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  $('.hidden').removeClass('hidden').hide();
});


var updateTaskForm = function(select){
  var $select = $(select);
  var type = $select.val();
  var max_freq = 1;
  $('#offset').hide();
  $("#frequenzy").hide();
  switch (type) {
    case 'day': {
      max_freq = 365;
    };break;
    case 'week': {
      $('#offset').show();
      max_freq = 52;
    };break;
    case 'month': {
      max_freq = 12;
    };break;
    case 'year': {
      max_freq = 10;
    };break;
    case 'once': {
      return;
    }
  }
  updateFrequenzies(max_freq);
}

var updateFrequenzies = function(max_freq){
  $("#frequenzy").show();
  var $select = $("#freq");
  $select.html("");
  for (var i = 1; i <= max_freq; i++){
    $select.append('<option>'+i+'</option>');
  }
}


