package com.colorhook.managers.toolTipClasses{
	
	import flash.events.Event;
	
	public class ToolTipEvent extends Event{
		
		public static const TOOLTIP_REDRAW:String="ToolTipRedraw";
		public static const TOOLTIP_SHOW:String="ToolTipShow";
		public static const TOOLTIP_HIDE:String="ToolTipHide";
		
		public function ToolTipEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false){
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event{
			return new ToolTipEvent(type,bubbles,cancelable);
		}
		
	}
}