package com.colorhook.magic{

	import flash.events.Event;
	public class MagicEvent extends Event {
		public static  const SHOW:String="show";
		public static  const CLEAR:String="clear";
		public function MagicEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false) {
			super(type,bubbles,cancelable);
		}
		override public function clone():Event {
			return new MagicEvent(this.type,this.bubbles,this.cancelable);
		}
	}
}