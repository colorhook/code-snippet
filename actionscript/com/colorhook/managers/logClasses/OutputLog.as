package com.colorhook.managers.logClasses
{
	
	/**
	 * @version	1.0
	 * @author colorhook
	 */

	public class OutputLog extends AbstractLog implements ILog
	{
		
		public function OutputLog() 
		{
		}
		public override function log(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}
		
		public override function info(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}
		
		public override function debug(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}
	
		public override function warning(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}
		
		public override function error(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}
	
		public override function fatal(msg:String, object:Object = null, arguments:Array = null):void {
			super.log(msg, object, arguments);
			trace(currentLog);
		}

	}
	
}