package com.colorhook.managers.toolTipClasses{

	import flash.display.DisplayObject;

	public interface IToolTipManager {
		
		function setToolTip(target:DisplayObject,text:String):void;
		
		function removeToolTip(target:DisplayObject):void;
		
		function containsTarget(target:DisplayObject):Boolean;
		
		function get currentTarget():DisplayObject;
		
		function get toolTip():ToolTip;
		
		function set toolTip(value:ToolTip):void;
		
		function get enabled():Boolean;

		function set enabled(value:Boolean):void;

		function get hideDelay():Number;

		function set hideDelay(value:Number):void;

		function get scrubDelay():Number;

		function set scrubDelay(value:Number):void;

		function get showDelay():Number;

		function set showDelay(value:Number):void;
		
		function get movable():Boolean;

		function set movable(value:Boolean):void;
	}
}