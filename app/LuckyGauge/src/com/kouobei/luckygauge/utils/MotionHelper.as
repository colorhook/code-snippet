package com.kouobei.luckygauge.utils {
	import adobe.utils.CustomActions;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author 正邪
	 */
	public class MotionHelper{
		
		public static const PRIZE_NO_1:String = 'PrizeNo1';
		public static const PRIZE_NO_2:String = 'PrizeNo2';
		public static const PRIZE_NO_3:String = 'PrizeNo3';
		public static const PRIZE_NO_4:String = 'PrizeNo4';
		public static const PRIZE_NO_5:String = 'PrizeNo5';
		
		protected static var PRIZE_MAP:*= {
			'PrizeNo0': { min:5, max:55 },
			'PrizeNo1': { min:65, max:115 },
			'PrizeNo2': { min:125, max:175 },
			'PrizeNo3': { min:185, max:235 },
			'PrizeNo4': { min:245, max:295 },
			'PrizeNo5': { min:305, max:355 }
		}
		
		//protected static var logger:ILogger = new Logger('MotionHelper');
		
		public static function getRotateByPrizeNo(value:String):Number {
			var arr:Array = [];
			arr[0] = 'PrizeNo0';
			arr[1] = 'PrizeNo3';
			arr[2] = 'PrizeNo2';
			arr[3] = 'PrizeNo5';
			arr[4] = arr[5] = arr[6] = arr[7] = arr[8] = 'PrizeNo4';
			arr[9] = 'PrizeNo1';
			
			var zone:*= PRIZE_MAP[arr[int(value)]];
			if (zone == null) {
				throw new Error("Fatal Error");
			}
			
			var min:Number = zone.min;
			var max:Number = zone.max;
			
			var result:Number = min + Math.random() * (max - min);
			//logger.info("current angle should be between " + min + " and "+max+'{result}->'+result);
			return result;
		}
		
	}
}