document.addEventListener("turbolinks:load", function() {
  function appendOption(category){
    let html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
                            <option value="選択してください" data-category="選択してください">選択してください</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.listing-form-box').append(childSelectHtml);  
  } 
  
  function appendGrandchidrenBox(insertHTML){
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                                <select class="listing-select-wrapper__box--select" id="grandchild_category" name="category_id">
                                  <option value="選択してください" data-category="選択してください">選択してください</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.listing-form-box').append(grandchildSelectHtml);
  }   
  $('#parent_category').on('change', function(){
    let parentCategory = document.getElementById('parent_category').value;   
    if (parentCategory != "選択してください"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        
       
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })  
    }else{
      $('#children_wrapper').remove(); 
      $('#grandchildren_wrapper').remove();
      
      
    }
  });
  $('.listing-form-box').on('change', '#child_category', function(){
    let childId = $('#child_category option:selected').data('category');
    if (childId != "選択してください"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); 
          
        
          let insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); 
    }
  });
  
});