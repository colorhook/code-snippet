package com.colorhook.managers{
	
	import com.colorhook.managers.toolTipClasses.*;
	
	import flash.display.DisplayObject;
	
	public class ToolTipManager{
		
		public function ToolTipManager(){
			throw new Error("ToolTipManager is a static class.");
		}
		
		private static function get impl():ToolTipManagerImpl{
			return ToolTipManagerImpl.getInstance();
		}
		
		
		public static function get toolTip():ToolTip {
			return impl.toolTip;
		}
		
		public static function get currentTarget():DisplayObject {
			return impl.currentTarget;
		}
		
		public static function set toolTip(value:ToolTip):void{
			impl.toolTip=value;
		}
		
		public static function get enabled():Boolean {
			return impl.enabled;
		}
		
		public static function set enabled(value:Boolean):void {
			impl.enabled=value;
		}
		
		public static function get hideDelay():Number {
			return impl.hideDelay;
		}
		public static function set hideDelay(value:Number):void {
			impl.hideDelay=value;
		}
		public static function get scrubDelay():Number {
			return impl.scrubDelay;
		}
		public static function set scrubDelay(value:Number):void {
			impl.scrubDelay=value;
		}
		public static function get showDelay():Number {
			return impl.showDelay;
		}
		public static function set showDelay(value:Number):void {
			impl.showDelay=value;
		}
		
		public static function get movable():Boolean {
			return impl.movable;
		}
		public static function set movable(value:Boolean):void {
			impl.movable=value;
		}
		
		public static function setToolTip(target:DisplayObject,text:String):void {
			impl.setToolTip(target,text);
		}
		
		
		public static function removeToolTip(target:DisplayObject):void {
			impl.removeToolTip(target);
		}
		
		public static function containsTarget(target:DisplayObject):Boolean {
			return impl.containsTarget(target);
		}
		
		
	}
}