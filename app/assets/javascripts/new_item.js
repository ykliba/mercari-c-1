$(document).on('turbolinks:load', function(){
  $('#image-input').on('change', function(e){
    let files = e.target.files;
    $.each(files, function(index, file) {
      let reader = new FileReader();

      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      
      reader.onload = (function(file){
        return function(e){
          let imageLength = $('#output-box').children('li').length;
          

          let labelLength = $("#image-input>label").eq(-1).data('label-id');
         
          $('#image-input').before(`<li class="preview-image" id="upload-image${labelLength}" data-image-id="${labelLength}">
                                      <figure class="preview-image__figure">
                                        <img src='${e.target.result}' title='${file.name}' >
                                      </figure>
                                      <div class="preview-image__button">
                                        <a class="preview-image__button__edit">編集</a>
                                        <a class="preview-image__button__delete" data-image-id="${labelLength}">削除</a>
                                      </div>
                                    </li>`);
          $("#image-input>label").eq(-1).css('display','none');
          

          if (imageLength < 9) {
            $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                        <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                        <i class="fas fa-camera fa-lg"></i>
                                      </label>`);
          };
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
  $(document).on('click', '.preview-image__button__delete', function(){
    let targetImageId = $(this).data('image-id');
    $(`#upload-image${targetImageId}`).remove();
    $(`[for=item_images${targetImageId}]`).remove();

    let imageLength = $('#output-box').children('li').length;
    if (imageLength ==9) {
      let labelLength = $("#image-input>label").eq(-1).data('label-id');
      $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                  <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                  <i class="fas fa-camera fa-lg"></i>
                                </label>`);
    };
  });
  $("textarea").keyup(function(){
    let txtcount = $(this).val().length;
    $("#word-count").text(txtcount);
  });
  $('#item_price').keyup(function(){
    let price= $(this).val();
    if (price >= 300 && price <= 9999999){
      let fee = Math.floor(price * 0.1);
      let profit = (price - fee);
      $('.price-box__fee-box__number').text('¥'+fee.toLocaleString());
      $('.price-box__profit-box__number').text('¥'+profit.toLocaleString());
    } else{
      $('.price-box__fee-box__number').html('ー');
      $('.price-box__profit-box__number').html('ー');
    }
  });
});


// $(document).on('turbolinks:load', function(){
//   $(function(){
//     function buildHTML(count) {
//       var html = `<div class="preview-box" id="preview-box__${count}">
//                     <div class="upper-box">
//                       <img src="" alt="preview">
//                     </div>
//                     <div class="lower-box">
//                       <div class="update-box">
//                         <label class="edit_btn">編集</label>
//                       </div>
//                       <div class="delete-box" id="delete_btn_${count}">
//                         <span>削除</span>
//                       </div>
//                     </div>
//                   </div>`
//       return html;
//     }

//     function setLabel() {
//       var prevContent = $('.label-content').prev();
//       labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
//       $('.label-content').css('width', labelWidth);
//     }

//     $(document).on('change', '.hidden-field', function() {
//       setLabel();
//       var id = $(this).attr('id').replace(/[^0-9]/g, '');
//       $('.label-box').attr({id: `label-box--${id}`,for: `item_item_photos_attributes_${id}_image`});
//       var file = this.files[0];
//       var reader = new FileReader();
//       reader.readAsDataURL(file);
//       reader.onload = function() {
//         var image = this.result;
//         if ($(`#preview-box__${id}`).length == 0) {
//           var count = $('.preview-box').length;
//           var html = buildHTML(id);
//           var prevContent = $('.label-content').prev();
//           $(prevContent).append(html);
//         }
//         $(`#preview-box__${id} img`).attr('src', `${image}`);
//         var count = $('.preview-box').length;
//         if (count == 5) { 
//           $('.label-content').hide();
//         }

//         setLabel();
//         if(count < 5){
//           $('.label-box').attr({id: `label-box--${count}`,for: `item_item_photos_attributes_${count}_image`});
//         }
//       }
//     });

//     $(document).on('click', '.delete-box', function() {
//       var count = $('.preview-box').length;
//       setLabel(count);
//       var id = $(this).attr('id').replace(/[^0-9]/g, '');
//       $(`#preview-box__${id}`).remove();
//       console.log("new")
//       $(`#item_item_photos_attributes_${id}_image`).val("");

//       var count = $('.preview-box').length;
//       if (count == 4) {
//         $('.label-content').show();
//       }
//       setLabel(count);
      
//       if(id < 5){
//         $('.label-box').attr({id: `label-box--${id}`,for: `item_item_photos_attributes_${id}_image`});
//       }
//     });
//   });
//   $("textarea").keyup(function(){
//     let txtcount = $(this).val().length;
//     $("#word-count").text(txtcount);
//   });
//   $('#item_price').keyup(function(){
//     let price= $(this).val();
//     if (price >= 300 && price <= 9999999){
//       let fee = Math.floor(price * 0.1);
//       let profit = (price - fee);
//       $('.price-box__fee-box__number').text('¥'+fee.toLocaleString());
//       $('.price-box__profit-box__number').text('¥'+profit.toLocaleString());
//     } else{
//       $('.price-box__fee-box__number').html('ー');
//       $('.price-box__profit-box__number').html('ー');
//      }
//   });
// });

