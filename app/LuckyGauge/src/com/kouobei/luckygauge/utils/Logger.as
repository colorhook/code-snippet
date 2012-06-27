package com.kouobei.luckygauge.utils {
	/**
	 * ...
	 * @author 正邪
	 */
	public class Logger implements ILogger{
		
		private var targetDesc:String;
		
		public function Logger(target:*) {
			targetDesc = String(target);
		}
		public function log(...rest) :void{
			sendInfo('['+targetDesc+':LOG]', rest);
		}
		
		public function info(...rest):void {
			sendInfo('['+targetDesc+':INFO]', rest);
		}
		
		public  function debug(...rest):void {
			sendInfo('['+targetDesc+':DEBUG]', rest);
		}
		
		public function error(...rest):void {
			sendInfo('['+targetDesc+':ERROR]', rest);
		}
		
		public function fatal(...rest):void {
			sendInfo('['+targetDesc+':FATAL]', rest);
		}
		
		protected function sendInfo(...rest):void {
			trace(rest);
		}
		
	}

}