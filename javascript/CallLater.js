/**
 * Copyright (c) 2010 the original author or authors
 * @author colorhook@gmail.com
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

/** 
 * The CallLater is utility class to help saving performance while execute much cost functions, methods or tasks.
 * Inspired by the component source code in Flash.
 */
var CallLater = function(duration){

	var inCallLaterPhase,
		 callLaterFlag,
		 methodMap={},
		 defaultDuration=20,
		 ToString = Object.prototype.toString;
		 
	duration=isNaN(duration) ? defaultDuration : (duration > 0 ? duration : defaultDuration);
	
	function executeCallLater(){
		inCallLaterPhase = true;

		for(var f in methodMap){
			var item=methodMap[f],
				 func=item.method,
				 args=item.args,
				 target=item.target;
			
			func.apply(target, args);
			delete methodMap[f];
		}
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

 		methodMap[method]={ method: method, args: args, target: target };

		if (!callLaterFlag) {
			callLaterFlag=true;
			setTimeout(executeCallLater, duration);
		}
	}
};