package com.colorhook.managers 
{
	import flash.utils.Dictionary;
	
	import com.colorhook.managers.logClasses.ILog;

	/**
	 * @version	1.0
	 * @author colorhook
	 */
	public class LogManager 
	{
		
		protected static var logMap:Dictionary = new Dictionary;
		
		public function LogManager() 
		{
			throw new Error("LogManager is a static class");
		}
		
		public static function registerLog(name:String, log:ILog):void {
			if (logMap[name] != null) {
				throw new Error("a log named " + name + " has registered already.");
				return;
			}
			logMap[name] = log;
		}
		
		public static function unregisterLog(name:String):void {
			delete logMap[name];
		}
		
		public static function log(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.log(msg, object, arguments);
			}
		}
		
		public static function info(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.info(msg, object, arguments);
			}
		}
		
		public static function debug(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.debug(msg, object, arguments);
			}
		}
		
		public static function warning(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.warning(msg, object, arguments);
			}
		}
		
		public static function error(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.error(msg, object, arguments);
			}
		}
		
		public static function fatal(msg:String, object:Object=null, arguments:Array = null):void {
			for each(var log:ILog in logMap) {
				log.fatal(msg, object, arguments);
			}
		}
	}
	
}