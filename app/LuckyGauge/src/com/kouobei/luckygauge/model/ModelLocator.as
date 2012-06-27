package com.kouobei.luckygauge.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 正邪
	 */
	public class ModelLocator extends EventDispatcher{
		public static const SERVICE_RESULT:String = '<serviceResult>';
		public static const SERVICE_FAULT:String = '<serviceFault>';
		public static const AVAIABLE_COUNT_CHANGE:String = '<avaiableCountChange>';
		public static const PRIZE_DATA_CHANGED:String = "<prizeDataChanged>";
		public static const INITIALIZED:String = "<initialized>";
		public var response:String;
		
		public var yui_id:String;
		public var kbToken:String;
		public var hasSignup:Boolean;
		public var username:String='';
		public var tomorrowcount:int;
		public var code:String;
		public var prize:String;
		public var deliveryid:String;
		public var prizeData:*;

		private var _availableCount:int;
		public var playing:Boolean = false;
		
		protected static var instance:ModelLocator;
		
		public function ModelLocator() {
			if (instance != null) {
				throw new Error('ModelLocator is a singleton');
			}
		}
		
		public static function getInstance():ModelLocator {
			if (instance == null) {
				instance = new ModelLocator();
			}
			return instance;
		}
		
		public function set avaiableCount(value:int):void {
			if (value < 0) {
				value = 0;
			}
			if (value == _availableCount) {
				return;
			}
			_availableCount = value;
			this.dispatchEvent(new Event(AVAIABLE_COUNT_CHANGE));
		}
		
		public function get avaiableCount():int {
			return _availableCount;
		}
		
		public function convertPrizeData(n:int):*{
			if (n == 9) {
				return {prize:'again'}
			}
			if (n >= 4 && n <= 8) {
				return { prize:'score', param:(9 - n) };
			}
			if (n == 3) {
				return { prize:'cash', param:5 };
			}
			if (n == 2) {
				return { prize:'cash', param:50 };
			}
			
			
			
			
			
			
			if (n == 1) {
				return { prize: 'cash', param:100 } ;
			}
			if (n == 0) {
				return { prize:'iPad' };
			}
			return { prize:'noChance' };
		}
		
		public function setRandomPrize():void {
			var r:int = Math.floor(Math.random() * 10);
			this.prize = "" + r;
		}
	}
}