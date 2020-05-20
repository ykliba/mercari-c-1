$(function(){
  let request = $("#request2").attr("action");
  if(request.indexOf("new") != -1|| request.indexOf("edit") != -1){
    $.ajax({
      url: "/items/set_parents"
    }).done(function(data){
      $("#category-select2").append(`<select class="new-wrapper__main__input-select select-parent" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
      data.parents.forEach(function(parent){
        $(".select-parent").append(`<option value="${parent.id}">${parent.name}</option>`);
      })
      $(".select-parent").on("change", function(){
        $(".select-child").remove();
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-parent").attr("id"  , "item_category_id");
          $(".select-parent").attr("name", "item[category_id]");
          $(".select-parent").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_children",
            data    : {parent_id: $(this).val()},
            dataType: "json"
          }).done(function(data){
            $(".select-parent").attr("id"  , "select-parent");
            $(".select-parent").attr("name", "select-parent");
            $(".select-parent").css("margin-bottom", "10px");
            $("#category-select2").append(`<select class="new-wrapper__main__input-select select-child" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
            data.children.forEach(function(child){
              $(".select-child").append(`<option value="${child.id}">${child.name}</option>`);
            })
          })
        }
      })
      $("#category-select2").on("change", ".select-child", function(){
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-child").attr("id"  , "item_category_id");
          $(".select-child").attr("name", "item[category_id]");
          $(".select-child").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_grandchildren",
            data    : {ancestry: `${$(".select-parent").val()}/${$(this).val()}`},
            dataType: "json"
          }).done(function(data){
            $(".select-child").attr("id"  , "select-parent");
            $(".select-child").attr("name", "select-parent");
            $(".select-child").css("margin-bottom", "10px");
            $("#category-select2").append(`<select class="new-wrapper__main__input-select select-grandchild" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
            data.grandchildren.forEach(function(grandchild){
              $(".select-grandchild").append(`<option value="${grandchild.id}">${grandchild.name}</option>`);
            })
          })
        }
      })
    })
  }



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