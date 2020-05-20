$(function(){
  let index = [0,1,2,3,4,5,6,7,8,9];
  let request = $("#image-wrapper").attr("action");
  if(request != undefined && request.indexOf("edit") != -1){
    $.ajax({
      url: "/items/set_item_photos",
      data: {id: request.replace(/[^0-9]/g, '')},
      dataType: "json"
    }).done(function(data){
      data.item_photos.forEach(function(d){
        buildImage(d.image.url);
      })
      $(".hidden").hide();
      $(".flexbox").on("click", ".delete-btn", function(){
        let targetDeleteIndex = Number($(this).attr("index"));
        $(`#item_item_photos_attributes_${targetDeleteIndex}__destroy`).prop('checked', true);
      })
    })
  }
  

  $(".flexbox").on("click", ".delete-btn", function(){
    let targetIndex = Number($(this).attr("index"));
    index.push(targetIndex);
    if($(this).parent().parent().attr("class") == "new-wrapper__main__preview-first"){
      $(".new-wrapper__main__preview .new-wrapper__main__preview__image:first").appendTo(".new-wrapper__main__preview-first");
    }
    if(index.length > 6){
      $(".new-wrapper__main__image-field").css("width",(index.length-5)*132);
    }else if(index.length == 6){
      $("#image-field-second").remove();
      $(".new-wrapper__main__preview").remove();
      $(".new-wrapper__main__preview-first").attr("class", "new-wrapper__main__preview");
      $(".new-wrapper__main__image-field").css("display","flex");
    }else if(index.length == 1){
      $("#image-field-second").css("display","flex");
      $("#image-field-second").css("width",index.length*132);
    }else{
      $("#image-field-second").css("width",index.length*132);
    }
    $("#image-wrapper").attr("for",`item_item_photos_attributes_${targetIndex}_image`);
    $(this).parent().remove();
    $(`#product_images_attributes_${targetIndex}_image`).remove();
    $(".flexbox").append(`<input class="file-field" type="file" name="item[item_photos_attributes][${targetIndex}][image]" id="item_item_photos_attributes_${targetIndex}_image">`);
   })
    let buildImage = function(url){
    if(index.length != 0){
      $(".new-wrapper__main__preview").append(`
        <div class="new-wrapper__main__preview__image" index=${index[0]}>
        <img class="new-wrapper__main__preview__image__img" src="${url}">
        <div class="delete-btn" index=${index[0]}><i class="far fa-times-circle"></i></div>
      `);
      $(".flexbox").append(`<input class="file-field" type="file" name="item[item_photos_attributes][${index[1]}][image]" id="item_item_photos_attributes_${index[1]}_image">`);
      $("#image-wrapper").attr("for",`item_item_photos_attributes_${index[1]}_image`);
      index.shift();
      if(index.length > 5){
        $("#image-field-second").remove();
        $(".new-wrapper__main__image-field").css("display","flex");
        $(".new-wrapper__main__image-field").css("width",(index.length-5)*132);
      }else if(index.length == 5){
        $(".new-wrapper__main__image-field").css("display","none");
        $("#image-wrapper").append(`
          <div class="new-wrapper__main__image-field" id="image-field-second">
            <i class="fas fa-camera"></i>
            <div class="new-wrapper__main__image-field__text">
              ドラッグアンドドロップ
              <br>
              またはクリックしてファイルをアップロード
            </div>
          </div>
        `);
        $(".new-wrapper__main__preview").attr("class", "new-wrapper__main__preview-first");
        $(".new-wrapper__main__preview-first").after(`<div class="new-wrapper__main__preview"></div>`);
      }else if(index.length == 0){
        $("#image-field-second").css("display","none");
      }
      $("#image-field-second").css("width",index.length*132);
    }
  }
  $(".flexbox").on("change", function(e){
    let blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})


