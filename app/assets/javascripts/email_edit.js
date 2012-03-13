var values = new Array();
$(function() {
	$( "#email_expires_on" ).datepicker( { dateFormat: "yy-mm-dd"});
	var remove_fn = function(event){
		event.preventDefault();
		value = $('input', $(this).parent()).val();
		values.push(value);
		$(this).parent().remove();	
	};

	$(".remove_btn").click(remove_fn);
	
	$("input.submit_btn").click(function(event){
		// var i = 0;
		// for(deleted in values) {
			// event.preventDefault();
			// var input = $("<input>").attr("type", "hidden").attr("deleted", i).val(values[deleted]);
			// $('#form1').append($(input));
			// alert(values[deleted]);
		// };
		var allElements = ""
		$('.forward_email_field').children().each(function(index, Element){	
			var a = $("input", this).val();
			i=0;
			if(a) {
				allElements += a + " "
			};			
		});
		var input = $("<input>").attr("type", "hidden").attr("name", "email[forward_email]").val(allElements);
		$('.edit_email').append($(input));
		$('.forward_email_field').remove();
		
	});
	
	$(".add_btn").click(function(event){
		event.preventDefault();
		$('.forward_email_field').append($(".hidden.forward_email").clone().removeClass("hidden"));
		$(".remove_btn").unbind("click")
		$(".remove_btn").bind("click",remove_fn);
	});
});



