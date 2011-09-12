// jQuery -------------------------------------------------------------

$(document).ready(function() {
  setTimeout(hideFlashes, 5000);
});

var hideFlashes = function() {
  $('p.notice, p.warning, p.error, p.alert').slideUp(750);
}
// --------------------------------------------------------------------