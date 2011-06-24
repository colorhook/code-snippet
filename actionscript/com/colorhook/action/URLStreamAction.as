package com.colorhook.action{
	
	import flash.net.URLStream;
	import flash.net,URLRequest;
	import flash.events,Event;
	
	public class URLStreamAction extends EventListener implements IAction{
		
		protected var _loader:URLStream;
		private var _request:URLRequest;
		
		public function URLStreamAction(request:URLRequest){
			_loader=new URLStream;
			_request=request;
		}
		
		public function execute():void{
			_loader.addEventListener(Event.COMPLETE,onLoaderComplete,false,0,true);
			_loader.load(_request);
		}
		
		public function get loader():URLLoader(){
			return _loader;
		}
		
		private function onLoaderComplete(e:Event):void{
			e.target.removeEventListener(Event.COMPLETE,onLoaderComplete);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}