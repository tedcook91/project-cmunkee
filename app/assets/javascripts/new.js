$(document).ready(function(){
    $('.addSymbol').click(function(e){
        e.preventDefault();
        $('div.symbol').append('<div class ="form"><input type="text" class="field" placeholder="Symbol")>'+
        '<button class="removeSymbol" type="button">remove</button></div>');
    });
$("div.symbol").on('click', '.removeSymbol', function(){
    $(this).closest('.form').remove();
});
});