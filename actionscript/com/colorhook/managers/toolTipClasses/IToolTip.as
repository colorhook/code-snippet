package com.colorhook.managers.toolTipClasses{
	
	import flash.events.IEventDispatcher;
	
	public interface IToolTip extends IEventDispatcher{
		
		function set text(value:String):void;
		function get text():String;
		
		
	}
}