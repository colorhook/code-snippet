package com.colorhook.widget{

	import flash.events.Event;
	import flash.display.DisplayObject;
	
	public class FisheyeDockEvent extends Event{
		
		public static const ITEM_CLICK:String="itemClick";
		public static const ITEM_DOUBLE_CLICK:String="itemDoubleClick";
		public static const ITEM_ROLL_OVER:String="itemRollOver";
		public static const ITEM_ROLL_OUT:String="itemRollOut";
		
		public var index:int;
		public var item:DisplayObject;
		
		public function FisheyeDockEvent(type:String,index:int=0,bubbles:Boolean=false,cancelable:Boolean=false){
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event{
			return new FisheyeDockEvent(type, index, bubbles, cancelable);
		}
	}
}