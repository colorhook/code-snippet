/**
 * Copyright (c) 2011 the original author or authors
 * @author colorhook@gmail.com
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

/** 
 * @access public
 * @description The CallLater is utility class to help saving performance while execute much cost functions, methods or tasks.
 * Inspired by the component source code in Flash.
 * @example
 * <pre>
 * var callLater = new CallLater();
 * var func1 = function(){
 *		console.log("func1");
 * }
 * var func2 = function(params){
 *		console.log("func2:"+func2);
 * }
 * callLater.call(func1);
 * callLater.call(func1);
 * callLater.call(func2, 'a');
 * callLater.call(func2, 'b');
 * </pre>
 */
var CallLater = function(duration){

	var inCallLaterPhase,
		 callLaterFlag,
		 defaultDuration=20,
		 ToString = Object.prototype.toString,
		 methodMap=(function(){
			var data = [];
			return {
				add: function(f, a, t){
					if(this.getIndex(f) == -1){
						data.push({f:f, a:a, t:t});
					}
				},
				getIndex: function(f){
					for(var i = 0, l = data.length; i < l; i++){
						if(data[i].f == f){
							return i;
						}
					}
					return -1;
				},
				remove: function(f){
					var i = this.getIndex(f);
					if(i >= 0){
						data.splice(i, 1);
					}
				},
				each: function(callback){
					for(var i = 0, l = data.length; i < l; i++){
						callback(data[i].f, data[i].a, data[i].t);
					}
				},
				reset: function(){
					data = [];
				}
			}
		 })();
		 
	duration=isNaN(duration) ? defaultDuration : (duration > 0 ? duration : defaultDuration);
	
	function executeCallLater(){
		inCallLaterPhase = true;
		methodMap.each(function(f, a, t){
			f.apply(t, a);
		});
		methodMap.reset();
		inCallLaterPhase = false;
		callLaterFlag=false;
	}
	/**
	 * @access public 
	 * @description add a method to the queue and execute them soon later. 
	 */
	this.call = function(method, args, target) {
		if (inCallLaterPhase || ToString.call(method) !== '[object Function]'){
			return;
		}
			
		if (args && (ToString.call(args) != '[object Array]')) {
			args = [ args ];
		}

 		methodMap.add(method, args, target);

		if (!callLaterFlag) {
			callLaterFlag=true;
			setTimeout(executeCallLater, duration);
		}
	}
};