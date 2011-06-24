package com.colorhook.action{
	
	import flash.display.Loader;
	import flash.net,URLRequest;
	import flash.events,Event;
	
	public class LoaderAction extends EventListener implements IAction{
		
		protected var _loader:Loader;
		private var _request:URLRequest;
		
		public function LoaderAction(request:URLRequest){
			_loader=new Loader;
			_request=request;
		}
		
		public function execute():void{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete,false,0,true);
			_loader.load(_request);
		}
		
		public function get loader():Loader(){
			return _loader;
		}
		
		private function onLoaderComplete(e:Event):void{
			e.target.removeEventListener(Event.COMPLETE,onLoaderComplete);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}