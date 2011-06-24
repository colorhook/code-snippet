package com.colorhook.managers.logClasses
{
	
	/**
	 * @version	1.0
	 * @author colorhook
	 */

	public interface ILog 
	{
		function log(msg:String, object:Object = null, arguments:Array = null):void;
		
		function info(msg:String, object:Object = null, arguments:Array = null):void;
		
		function debug(msg:String, object:Object = null, arguments:Array = null):void;
		
		function warning(msg:String, object:Object = null, arguments:Array = null):void;
		
		function error(msg:String, object:Object = null, arguments:Array = null):void;
		
		function fatal(msg:String, object:Object = null, arguments:Array = null):void;
	}
		
	
}