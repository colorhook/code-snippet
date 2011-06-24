package com.colorhook.managers.logClasses
{
	import flash.events.EventDispatcher;
	
	/**
	 * @version 1.0
	 * @author colorhook
	 */

	public class AbstractLog  implements ILog
	{
		protected var currentLog:String;
		
		public function AbstractLog() 
		{
		}
		public function log(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "LOG: "+format(msg, object, arguments);
		}
		
		public function info(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "INFO: "+format(msg, object, arguments);
		}
		
		public function debug(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "DEBUG: "+format(msg, object, arguments);
		}
	
		public function warning(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "WARNING: "+format(msg, object, arguments);
		}
		
		public function error(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "ERROR: "+format(msg, object, arguments);
		}
	
		public function fatal(msg:String, object:Object = null, arguments:Array = null):void {
			currentLog = "FATAL: " + format(msg, object, arguments);
		}
		
		protected function format(msg:String, object:Object = null, arguments:Array = null):String {
			var result:String = msg;
			if (object!=null) {
				result += "\t" + object.toString();
			}
			if (arguments!=null) {
				result += "\t"+arguments.toString();
			}
			return result;
		}
		
		
	}
	
}