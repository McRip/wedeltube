// jQuery -------------------------------------------------------------

$(document).ready(function() {
  setTimeout(hideFlashes, 3000);
});

var hideFlashes = function() {
  $('p.notice, p.warning, p.error').fadeOut(1500);
}
// --------------------------------------------------------------------