$(function() {
  function buildChildHTML(child){
    let html = `<a class="child_category" id="${child.id}" 
                 href="/category/${child.id}">${child.name}</a>`;
    return html;    
  }  
  $(".parent_category").on("mouseover", function() {    
    let id = this.id  
    $(".now-selected-red").removeClass("now-selected-red")
    $('#' + id).addClass("now-selected-red");
    $(".child_category").remove();
    $(".grand_child_category").remove();
    $.ajax({
      type: 'GET',
      url: '/category/new',
      data: {parent_id: id},
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) {
        let html = buildChildHTML(child);
        $(".children_list").append(html);
      })
    });
  });
  function buildGrandChildHTML(child){
    let html = `<a class="grand_child_category" id="${child.id}"
                 href="/category/${child.id}">${child.name}</a>`;
    return html;
  }
  $(document).on("mouseover", ".child_category", function () {
    let id = this.id
    $(".now-selected-gray").removeClass("now-selected-gray");
    $('#' + id).addClass("now-selected-gray");
    $.ajax({
      type: 'GET',
      url: '/category/new',
      data: {parent_id: id},
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) {
        var html = buildGrandChildHTML(child);
        $(".grand_children_list").append(html);
      })
      $(document).on("mouseover", ".child_category", function () {
        $(".grand_child_category").remove();
      });
    });
  });  
});

