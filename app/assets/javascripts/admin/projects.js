$( document ).ready(function() {
    $('.edit_checkbox-answer').check_just_one();
    $('#project_replace').trigger('click');
});

var deletePageFromHtml = function(element, name){
    var parent = element.parent();
    parent.remove();
};

$( document ).on('click', '.delete-button-js', function(){
    var id = $(this).parent().data('id');
    var name = $(this).parent().data('name');
    $.ajax({
        method: 'POST',
        url: '/admin/html/delete',
        type: 'json',
        data: {
            id: id
        },
        success: deletePageFromHtml($(this), name)
    });
   //console.log(id);
});
