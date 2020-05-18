$(document).on('turbolinks:load', function(){
  let request = $("#request2").attr("action");
  if(request.indexOf("new") != -1){
    $.ajax({
      url: "/items/set_parents"
    }).done(function(data){
      $("#category-select2").append(`<select class="new-wrapper__main__input-select select-parent2" name="item[category_id]2" id="item_category_id2"><option value="">選択してください</option></select>`);
      data.parents.forEach(function(parent){
        $(".select-parent2").append(`<option value="${parent.id}">${parent.name}</option>`);
      })
      $(".select-parent2").on("change", function(){
        $(".select-child2").remove();
        $(".select-grandchild2").remove();
        if($(this).val() == ""){
          $(".select-parent2").attr("id"  , "item_category_id2");
          $(".select-parent2").attr("name", "item[category_id]2");
          $(".select-parent2").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_children",
            data    : {parent_id: $(this).val()},
            dataType: "json"
          }).done(function(data){
            $(".select-parent2").attr("id"  , "select-parent2");
            $(".select-parent2").attr("name", "select-parent2");
            $(".select-parent2").css("margin-bottom", "10px");
            $("#category-select2").append(`<select class="new-wrapper__main__input-select select-child2" name="item[category_id]2" id="item_category_id2"><option value="">選択してください</option></select>`);
            data.children.forEach(function(child){
              $(".select-child2").append(`<option value="${child.id}">${child.name}</option>`);
            })
          })
        }
      })
      $("#category-select2").on("change", ".select-child2", function(){
        $(".select-grandchild2").remove();
        if($(this).val() == ""){
          $(".select-child2").attr("id"  , "item_category_id2");
          $(".select-child2").attr("name", "item[category_id]2");
          $(".select-child2").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_grandchildren",
            data    : {ancestry: `${$(".select-parent2").val()}/${$(this).val()}`},
            dataType: "json"
          }).done(function(data){
            $(".select-child2").attr("id"  , "select-parent2");
            $(".select-child2").attr("name", "select-parent2");
            $(".select-child2").css("margin-bottom", "10px");
            $("#category-select2").append(`<select class="new-wrapper__main__input-select select-grandchild2" name="item[category_id]2" id="item_category_id2"><option value="">選択してください</option></select>`);
            data.grandchildren.forEach(function(grandchild){
              $(".select-grandchild2").append(`<option value="${grandchild.id}">${grandchild.name}</option>`);
            })
          })
        }
      })
    })
  }
})