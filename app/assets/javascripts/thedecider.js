// put focus on first visible input, if any
$(document).ready( function() {
  var tgts = $('input:visible');
  if( tgts.length != 0 ) tgts.first().focus();
});

