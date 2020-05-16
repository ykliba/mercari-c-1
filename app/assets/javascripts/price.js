$(document).on('turbolinks:load', function(){
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
