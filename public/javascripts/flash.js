// jQuery -------------------------------------------------------------

$(document).ready(function() {
  setTimeout(hideFlashes, 2000);
});

var hideFlashes = function() {
  $('p.notice, p.warning, p.error').fadeOut(1500);
}
// --------------------------------------------------------------------