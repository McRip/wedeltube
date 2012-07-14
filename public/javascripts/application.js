$(function() {
    $('body').delegate('.videothumb', 'click', function() {
        document.location = $(this).find("a.title").attr('href');
    });
});