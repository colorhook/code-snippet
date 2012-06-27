/*
 * jQuery TreeSelect Plugin
 * TreeSelect 1.0 - Create a tree menu with ease.
 * Version 1.0.0
 * @requires jQuery v1.2.3
 * 
 * Copyright (c) 2010-1011 John Liao
 * Examples and docs at: http://colorhook.com/portfolio/treeselect
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * 
 */

(function($) { 
	
	$.fn.treeselect = function(options) {
		
		 //Build main options before element iteration
		 var opts = $.extend({}, $.fn.treeselect.defaults, options),
		 	selectedItems=[],
		 	focusedItem=null,
			showEventType=opts.clickMode?'click':'mouseover';
		 
		
		function closureAll(){
			focusedItem=null;
		 	while(selectedItems.length>0){
				selectedItems.pop().hide();
			}
		 }

		 
		 function doRecursive(dom,n){
		 	var $this=$(dom),
				lis=$this.find('>li');
				
			lis.each(function(i,p){
				var $p=$(p),
					$ul=$('>ul', $p).hide();
					doRecursive($ul, n+1);
				
				//If the current item is a leaf.
				if($ul.length==0)
				{
					$p.click(function(e){
						//stop event propagation;
						if (e.stopPropagation){
							e.stopPropagation(); 
						}else{
							e.cancelBubble = true;
						}
						
						//if the focused item is the same one as the previous item, then return.
						if(focusedItem==$p){
							return;
						}
						focusedItem=$p;

						if(opts.onChange){
							opts.onChange($p);
						}
						//If the onChange option set, exuecute the onChange callback.
						closureAll();
						
					});
				}
				//If the current item is a branch.
				else
				{
					$p.bind(showEventType, function(e){
						//stop event propagation;
						if (e.stopPropagation){
							e.stopPropagation(); 
						}else{
							e.cancelBubble = true;
						}
						//if the focused item is the same one as the previous item, then return.
						if(focusedItem==$p){
							return;
						}
						focusedItem=$p;
						//Hide the previous branches.
						while(selectedItems.length>n){
							selectedItems.pop().hide();
						}
						//Show next branch or leaf.
						selectedItems[n]= $ul.show();
					});
				}
	
			});
			return $this;
		}
		
		if(opts.data){
		 	var el= formatUL(options.data, opts.rootCls, opts.rootZIndex);
			$(el).appendTo(this);
		}
		 
		var ULchild=this.find('>ul');
		doRecursive(ULchild.length>0?ULchild:this,0);
		
		if(opts.autoHide){
			this.mouseleave(closureAll);
		}else{
			$(document).click(closureAll);
		}

		return this;
	}
	
	
	function formatUL(array, cls, n){
		if(!array||!array.length){
			return '';
		}
		n=isNaN(n)?10:n;

		var style=' style="z-index:'+n+';"'+(cls?('class="'+cls+'"'):''),
			 el="<ul"+style+">",
			 count=array.length;
			
		for(var i=0;i<count;i++){
			el+="<li><a>"+array[i].label+"</a>"+formatUL(array[i].data,null,n+10)+"</li>";
		}
		el+="</ul>";
		return el;
	}
		
	//DEFAULTS
	$.fn.treeselect.defaults={
	 	clickMode:true,
		autoHide:true,
		rootCls:'treeselect',
		rootZIndex:100
	 }
	
})(jQuery);