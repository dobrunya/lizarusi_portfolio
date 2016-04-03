/**
 * Created by lizarusi on 25.03.16.
 */
$.fn.check_just_one = function () {
    for (var i = 0; i < this.length; i++){
        this[i].addEventListener('click', unchecked, false);
    }
    function unchecked(){
        $this = $(this)[0];
        var temp = jQuery.grep( $('.edit_checkbox-answer'), function( a ){
            return a !== $this;
        });
        if(this.checked){
            if (this.id == 'project_replace') {
                $('.admin_main-html__replace').css('display', 'block')
            }
            else {
                $('.admin_main-html__replace').css('display', 'none')
            }
            $(temp).each(function(i, item){
                $(item).prop('checked', false);
            });

        }
        else {
            if (this.id == 'project_replace') {
                $('.admin_main-html__replace').css('display', 'none')
            }
            else {
                $('.admin_main-html__replace').css('display', 'block')
            }
            var item = $(temp)[0];
            if (item) {
                $(item).prop('checked', true);
                if (item.id == 'project_replace'){

                }
            }
        }
    }
};