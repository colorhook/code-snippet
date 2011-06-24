package com.colorhook.lite3d.view{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	import flash.display.DisplayObject;
	import com.colorhook.lite3d.geom.Point3D;
	import com.colorhook.lite3d.camera.ICamera3D;
	import com.colorhook.lite3d.scene.IScene3D;
	import com.colorhook.lite3d.render.IRenderEngine;
	
	public interface IView3D{
		
		function getChildPoint3D(child:DisplayObject):Point3D;
		
		function setChildPoint3D(child:DisplayObject,point:Point3D=null):void;
		
		function getAllChildren():Array;
		
		function setChildDepth(child:DisplayObject,depth:Number):void;
		
		function set scene(value:IScene3D):void;
		
		function get scene():IScene3D;
		
		function set camera(value:ICamera3D):void;
		
		function get camera():ICamera3D;
		
		function set renderer(value:IRenderEngine):void;
		
		function get renderer():IRenderEngine;
		
		function render():void;
		
	}
}