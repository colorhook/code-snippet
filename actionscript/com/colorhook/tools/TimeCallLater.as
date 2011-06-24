package com.colorhook.tools{
	
	
	/**
	 * @author colorhook
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	 import flash.utils.Dictionary;
	 import flash.utils.Timer;
	 import flash.events.TimerEvent;
	 
	public class TimeCallLater implements ICallLater{
		
		private var _duration:Number;
		private var methods:Dictionary;
		private var _timer:Timer;
		private var inCallLaterPhase:Boolean=false;
		
		public function NextTimeCallLater(duration:Number){
			this._duration=duration;
			methods=new Dictionary(true);
			_timer=new Timer(_duration);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler,false,0,true);
		}
		
		public function call(fun:Function):void{
			
			if (inCallLaterPhase) { return; }

			methods[fun]=true;
			
			if(!_timer.running){
				_timer.start();
			}
		}
		
		private function timerHandler(event:TimerEvent):void {
			_timer.stop()
			
			inCallLaterPhase = true;

			for (var method:Object in methods) {
				method();
				delete(methods[method]);
			}
			inCallLaterPhase = false;
			
		}
		
		
		public function get duration():Number{
			return _duration;
		}
		
		public function set duration(value:Number):void{
			if(value==_duration){
				return;
			}
			_duration=value;
			var running:Boolean=_timer.running;
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			_timer=new Timer(_duration);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler,false,0,true);
			if(running){
				_timer.start();
			}
		}
		
	}
}