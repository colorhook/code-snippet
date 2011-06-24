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
(function(d){function m(a,b,f){if(!a||!a.length)return"";f=isNaN(f)?10:f;b=' style="z-index:'+f+';"'+(b?'class="'+b+'"':"");b="<ul"+b+">";for(var e=a.length,c=0;c<e;c++)b+="<li><a>"+a[c].label+"</a>"+m(a[c].data,null,f+10)+"</li>";b+="</ul>";return b}d.fn.treeselect=function(a){function b(){for(i=null;c.length>0;)c.pop().hide()}function f(j,k){j=d(j);var n=j.find(">li");n.each(function(q,o){var g=d(o),l=d(">ul",g).hide();f(l,k+1);l.length==0?g.click(function(h){if(h.stopPropagation)h.stopPropagation();
else h.cancelBubble=true;if(i!=g){i=g;e.onChange&&e.onChange(g);b()}}):g.bind(p,function(h){if(h.stopPropagation)h.stopPropagation();else h.cancelBubble=true;if(i!=g){for(i=g;c.length>k;)c.pop().hide();c[k]=l.show()}})});return j}var e=d.extend({},d.fn.treeselect.defaults,a),c=[],i=null,p=e.clickMode?"click":"mouseover";if(e.data){a=m(a.data,e.rootCls,e.rootZIndex);d(a).appendTo(this)}a=this.find(">ul");f(a.length>0?a:this,0);e.autoHide?this.mouseleave(b):d(document).click(b);return this};d.fn.treeselect.defaults=
{clickMode:true,autoHide:true,rootCls:"treeselect",rootZIndex:100}})(jQuery);
