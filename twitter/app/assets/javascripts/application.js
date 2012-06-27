// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(function(){
	
	$("input.tweetSubmit").hide();
	
	$("textarea").click(function(){
		this.rows = 6;
		$("input.tweetSubmit").show();
		if (this.value == '') {
			$("input.tweetSubmit").attr("disabled", "disabled");
			$("input.tweetSubmit").css({'background-color' : '#F9F9F9', 
													 'color' : '#959595',
													 'border' : '1px solid #E0E0E0'}
													 );
		}
						
		var charLeft = 160 - this.value.length;
		$("td#charCount span#count b").replaceWith("<b>"+charLeft+"</b>");		
	});
	
	$("textarea").keyup(function(){
		var tMaxLen = 160
		var tCurLen = this.value.length;
	
		if ( tCurLen > tMaxLen )
		{
			this.value = this.value.substring(0, tMaxLen);
		}
	
		if (tCurLen == 0 || !this.value.match(/[A-z0-9]/)) {
			$("input.tweetSubmit").attr("disabled", "disabled");
			$("input.tweetSubmit").css({'background-color' : '#F9F9F9', 
																 'color' : '#959595',
																 'border' : '1px solid #E0E0E0'}
																 );
		}
		else {
			$("input.tweetSubmit").removeAttr("disabled");
			$("input.tweetSubmit").css({'background-color' : '#17A5D9', 
																 'color' : '#fff',
																 'border' : '1px solid #1284AE'}
																 );
		}
	
		var charLeft = tMaxLen - tCurLen
	
		if(charLeft < 0) {
			charLeft = 0;
		}

		$("#charCount span#count b").replaceWith("<b>"+charLeft+"</b>");	
	});
	
	$('input[value=Follow]').click(function(){
		$(this).attr('id','following');
	});
	
	$('input[value=Unfollow]').live("hover", function(){
		$(this).attr('id','unfollow');
	});
	
	$('input[value=Following]').mouseenter(function(){
		$(this).val('Unfollow');
		$(this).css({'background-color' : '#CC0000', 'border' : '1px solid #990000'});
	});
	
	$('input[value=Following]').mouseleave(function(){
		$(this).val('Following');
		$(this).css({'background-color' : '#17A5D9', 'border' : '1px solid #1284AE'});
	});
	
	$('div.retweetForm').hide();
	
	$('a.retweet').click(function(){
		var that = $(this).next();
		
		$('div.tweetsTable').css({'background-color' : 'rgba(0,0,0,0.3)', 'z-index' : '5'});
		$('div.retweetForm').offset({'top' : $(this).position().top - 65 });
		that.fadeIn(300);
	});

	$('input[value = Retweet]').live('click', function(){
		$(this).parent().parent().parent().parent().parent().parent().parent().fadeOut(100);
		$('div.tweetsTable').css({'background-color' : '#fff'});
	});
	
	$('input[value = Cancel]').live('click', function(){
		$(this).parent().parent().parent().parent().parent().parent().parent().fadeOut(100);
		$('div.tweetsTable').css({'background-color' : '#fff'});
	});
});

