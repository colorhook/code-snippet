var CallLater= (function(duration){

	var inCallLaterPhase,
	callLaterFlag,
	methodMap={},
	defaultDuration=1000;

	duration=isNaN(duration) ? defaultDuration : (duration > 0 ? duration : defaultDuration);

	function executeCallLater(){
		inCallLaterPhase = true;

		for(var f in methodMap){
			var item=methodMap[f],
				 func=item.method,
				 args=item.args,
				 target=item.target;
			if(typeof func=='function'){
				func.apply(target, args);
			}
			delete methodMap[f];
		}
		inCallLaterPhase = false;
		callLaterFlag=false;
	}

	return {
		call : function(method, args, target){
				if (inCallLaterPhase){
					return;
				}

				methodMap[method]={method:method,args:args,target:target};

				if(!callLaterFlag){
					callLaterFlag=true;
					setTimeout(executeCallLater, duration);
				}

			}
	}
})();



