var ImageRender = React.createClass({

   createImages: function(){
       var images = [];
       this.props.canvases.forEach(function(canvas){
           var curImg = new Image();
           curImg.src = canvas;
           images.push(curImg);
       });
       images.sort(function(a, b){return a.height - b.height});
       return images;
   },
   render: function(){
    var images = this.createImages();
    return (
        <div className="row">
            {
                images.map(function(image){
                    return <img style={{width: 200+'px'}} src={image.src}/>
                })
            }
        </div>
    );
   }
});