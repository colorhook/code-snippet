package com.colorhook.lite3d.camera{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	import flash.display.DisplayObject;
	import com.colorhook.lite3d.geom.Point3D;

	public interface ICamera3D{
		
		function get fov():Number;
		function set fov(value:Number):void;
		
		function get zoom():Number;
		function set zoom(value:Number):void;
		
		function get position():Point3D;
		function set position(value:Point3D):void;
		
		function get direction():Point3D;
		function set direction(value:Point3D):void;
		
		function get rotationX():Number;
		function set rotationX(value:Number):void;

		function get rotationY():Number;
		function set rotationY(value:Number):void;

		function get rotationZ():Number;
		function set rotationZ(value:Number):void;

		function get pitch():Number;
		function set pitch(value:Number):void;

		function get yaw():Number;
		function set yaw(value:Number):void;

		function get roll():Number;
		function set roll(value:Number):void;
		
	}
}