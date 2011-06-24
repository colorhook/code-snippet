package colorsprite.flip{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	
	
	/**
	*基于xml文件的翻页as3类
	*@Modify-Date 2008-8-30
	* @author colorsprite
	*/
	
	
	[Event(name="complete",type="flash.events.Event")]

	public class FlipBookData extends EventDispatcher {
		private var data:Array;
		public function FlipBookExample() {
			
		}
		public function load(xml:String):void {
			var xmlLoader:URLLoader=new URLLoader;
			xmlLoader.addEventListener(Event.COMPLETE,completeHandler);
			var request:URLRequest=new URLRequest(xml);
			xmlLoader.load(request);	
		}
		private function completeHandler(event:Event):void {
			var xmlLoader:URLLoader=URLLoader(event.target);
			var xmlArray:XML=new XML(xmlLoader.data);
			data=new Array();
			var list:XMLList=xmlArray.children();
			for(var i:uint=0;i<list.length();i++){
				data[i]=String(list[i].@name);
			}
			dispatchEvent(new Event("complete"));
			
		}
		public function getData():Array {
			return data;
		}

	}
}