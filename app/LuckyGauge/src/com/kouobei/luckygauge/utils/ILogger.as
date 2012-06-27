package com.kouobei.luckygauge.utils {
	
	/**
	 * ...
	 * @author 正邪
	 */
	public interface ILogger {
		
		function log(...rest):void;
		
		function info(...rest):void;
		
		function debug(...rest):void;
		
		function error(...rest):void;
		
		function fatal(...rest):void;
	}
	
}