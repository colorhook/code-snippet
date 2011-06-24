package com.colorhook.tools{
	
	
	/**
	 *	@author colorhook
	 * @copyright http://www.colorhook.com
	 *
	 * 
	 */
	 
	 import flash.display.DisplayObject;
	 import flash.utils.Dictionary;
	 import flash.events.Event;
	 
	public class FrameCallLater implements ICallLater{
		
		private var _target:DisplayObject;
		private var methods:Dictionary;
		private var inCallLaterPhase:Boolean=false;
		
		public function FrameCallLater(target:DisplayObject){
			this._target=target;
			methods=new Dictionary(true);
			super();
		}
		
		public function call(fun:Function):void{
			
			if (inCallLaterPhase||_target==null) { return; }
			
			methods[fun]=true;
			
			if (_target.stage != null) {
				_target.stage.addEventListener(Event.RENDER,callLaterDispatcher,false,0,true);
				_target.stage.invalidate();				
			} else {
				_target.addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher,false,0,true);
			}
		}
		
		private function callLaterDispatcher(event:Event):void {
			if (event.type == Event.ADDED_TO_STAGE) {
				_target.removeEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher);
				_target.stage.addEventListener(Event.RENDER,callLaterDispatcher,false,0,true);
				_target.stage.invalidate();
				return;
			} else {
				event.target.removeEventListener(Event.RENDER,callLaterDispatcher);
				if (_target.stage == null) {
					_target.addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher,false,0,true);
					return;
				}
			}

			inCallLaterPhase = true;

			for (var method:Object in methods) {
				method();
				delete(methods[method]);
			}
			inCallLaterPhase = false;
		}
		
		
		public function get target():DisplayObject{
			return _target;
		}
		
	}
}