package com.colorhook.action{
	
	import flash.net.URLLoader;
	import flash.net,URLRequest;
	import flash.events,Event;
	
	public class URLLoaderAction extends EventListener implements IAction{
		
		protected var _loader:URLLoader;
		private var _request:URLRequest;
		
		public function URLLoaderAction(request:URLRequest){
			_loader=new URLLoader;
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