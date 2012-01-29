// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $("a.fancybox").fancybox({'type': 'image'});

    // Below is the name of the textfield that will be autocomplete
    $('#recipient_email, #signers_email').autocomplete({
        // This shows the min length of charcters that must be 
        // typed before the autocomplete looks for a match.
                    minLength: 2,
        // This is the source of the auocomplete suggestions. In this case a 
        // list of emails from the users controller, in JSON format.
                    source: '/users/index.json'
    })

});
