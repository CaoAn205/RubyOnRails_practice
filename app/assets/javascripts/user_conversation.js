$(function(){
    $('#navbarSupportedContent #users-search').html('')
    $('#users-search-conversation #term').keyup(function(){
        $.get($('#users-search-conversation').attr('action'),
            {term: $('#users-search-conversation #term').val()},
            function(){
                 console.log($('#users-search-conversation #term').val())
                result = $('#users-result-conversation').html();
                if(!result){
                    $("#users-search-conversation #term").popover({
                        content: 'No result found',
                        placement: "bottom",
                        html: true,
                        trigger: "focus"
                    });
                } else {
                    $("#users-search-conversation #term").popover({
                        content: $('#users-result-conversation'),
                        placement: "bottom",
                        html: true,
                        trigger: "focus"
                    });
                }
                $("#users-search-conversation #term").popover('show');
            }
        )
    });
});