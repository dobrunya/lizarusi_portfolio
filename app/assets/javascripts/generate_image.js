/**
 * Created by lizarusi on 13.04.16.
 */
//= require html2canvas
//= require jquery
//= require jquery_ujs

$(window).load(function(){
    html2canvas(document.body, {
        onrendered: function(canvas) {
            path = window.location.href.split('/');
            title = path[path.length - 2]
            $.ajax({
                method: 'POST',
                url: '/admin/generate_image',
                type: 'json',
                data: {
                    title: title,
                    canvasURL: canvas.toDataURL()
                }
            });
        }
    });
});