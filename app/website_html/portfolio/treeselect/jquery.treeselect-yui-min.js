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
(function(b){b.fn.treeselect=function(k){var c=b.extend({},b.fn.treeselect.defaults,k),e=[],i=null,j=c.clickMode?"click":"mouseover";function f(){i=null;while(e.length>0){e.pop().hide()}}function h(o,p){var m=b(o),l=m.find(">li");l.each(function(r,s){var q=b(s),n=b(">ul",q).hide();h(n,p+1);if(n.length==0){q.click(function(t){if(t.stopPropagation){t.stopPropagation()}else{t.cancelBubble=true}if(i==q){return}i=q;if(c.onChange){c.onChange(q)}f()})}else{q.bind(j,function(t){if(t.stopPropagation){t.stopPropagation()}else{t.cancelBubble=true}if(i==q){return}i=q;while(e.length>p){e.pop().hide()}e[p]=n.show()})}});return m}if(c.data){var d=a(k.data,c.rootCls,c.rootZIndex);b(d).appendTo(this)}var g=this.find(">ul");h(g.length>0?g:this,0);if(c.autoHide){this.mouseleave(f)}else{b(document).click(f)}return this};function a(j,c,h){if(!j||!j.length){return""}h=isNaN(h)?10:h;var f=' style="z-index:'+h+';"'+(c?('class="'+c+'"'):""),e="<ul"+f+">",g=j.length;for(var d=0;d<g;d++){e+="<li><a>"+j[d].label+"</a>"+a(j[d].data,null,h+10)+"</li>"}e+="</ul>";return e}b.fn.treeselect.defaults={clickMode:true,autoHide:true,rootCls:"treeselect",rootZIndex:100}})(jQuery);