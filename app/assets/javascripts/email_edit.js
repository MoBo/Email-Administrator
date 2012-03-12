$(function() {
	$(".remove_btn").click(function(){
		$(this).parent().remove();
	});
  $('.add_btn').click(function() {
	  var num     = $('.clonedInput').length;
	  var newNum  = num + 1; //new Number(num + 1);
	
	  var newElem = $('#input' + num).clone().attr('id', 'input' + newNum);
	
	  inputs = jQuery("input", newElem);
	  for (i=0; i<inputs.length; ++i) {
	    rex_id = /(.*_)([0-9])(_.*)/;
	    rex_name = /(.*\[)([0-9])(\].*)/;
	
	    rex_id.exec(inputs[i].id)
	    inputs[i].id = RegExp.$1 + (newNum - 1) + RegExp.$3
	
	    rex_name.exec(inputs[i].name)
	    inputs[i].name = RegExp.$1 + (newNum - 1) + RegExp.$3
	
	    jQuery(inputs[i]).val("");
	  }
	
	  $('#input' + num).after(newElem);
	  $('#btnDel').attr('disabled', null);
	  $('#input' + newNum + " #btn_delete_contact").remove();
	  if (newNum == 5)
	      $('#btnAdd').attr('disabled','disabled');
  });

  $('#btnDel').click(function() {
      var num = $('.clonedInput').length;

      $('#input' + num).remove();
      $('#btnAdd').attr('disabled', null);

      if (num-1 == 1)
          $('#btnDel').attr('disabled','disabled');
  });
});

