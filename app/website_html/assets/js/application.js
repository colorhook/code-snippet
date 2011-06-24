$(document).ready(function(){
	 $('.kwicks').kwicks({
		 maxWidth: 190,
		 duration: 800,
		 easing: 'easeOutQuint'
		});
});

$(document).ready(function(){
	var selectedIndex=0;
	var buttonNavs=$("#photo_handler li a");
	buttonNavs.each(function(index,item){
		$(item).click(function(){
			$("#images").stop(true).animate({top:-400*index});
			onPhotoChanged(index);
		});
	});
	var shortNavs=$("#home .shortnav a");
	shortNavs.each(function(index,item){
		$(item).click(function(){
			$("#images").stop(true).animate({top:-400*index});
			onPhotoChanged(index);
		});
		
	});
	function onPhotoChanged(index){
		if(selectedIndex==index){
			return;
		}
		if(selectedIndex!=-1){
			$(shortNavs[selectedIndex]).removeClass('active');
			$(buttonNavs[selectedIndex]).removeClass('active');
		}
		selectedIndex=index;
		$(shortNavs[selectedIndex]).addClass('active');
		$(buttonNavs[selectedIndex]).addClass('active');
	}

});

$(document).ready(function(){
	$("#sidebar #social li a").each(function(index,item){
		var icon=$(item);
		icon.mouseover(function(){
			icon.fadeTo(200,0.6);
		}).mouseout(function(){
			icon.fadeTo(200,1);
		});
	});
});
$(document).ready(function(){
	$('.required').each(function(index,el){
			var inputItem=$(el);
			inputItem.blur(function(){
				validateForm();
			});
	});
	$('#commentform #submit_comment').click(function(){
		if(!validateForm()){
			$('.error-field').stop(true).animate({opacity:0.5}).animate({opacity:1});
		}else{
			$('#commentform').submit();
		}
	});
	
	function isValidEmail(email, ignoreMode){
		var email=$.trim(email);
		if(ignoreMode&&email==""){
			return true;
		}
		return email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)!=-1;
	}
	
	function validateForm(){
		var username_el=$('#commentform #author');
		var email_el=$('#commentform #email')
		var website_el=$('#commentform #website');
		var content_el=$('#commentform #comment');
		var isValid=true;
		if($.trim(username_el.val())==""){
			username_el.addClass('error-field');
			isValid=false;
		}else{
			username_el.removeClass('error-field');
		}
		if(!isValidEmail(email_el.val())){
			email_el.addClass('error-field');
			isValid=false;
		}else{
			email_el.removeClass('error-field');
		}
		if($.trim(content_el.val())==""){
			content_el.addClass('error-field');
			isValid=false;
		}else{
			content_el.removeClass('error-field');
		}
		return isValid
	}
});