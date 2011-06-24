package com.colorhook.lite3d.scene{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	import flash.display.DisplayObject;
	import com.colorhook.lite3d.geom.Point3D;
	
	public interface IScene3D{
		
		function addPoint3D(point:Point3D=null):Point3D;
		
	    function removePoint3D(point:Point3D):Point3D;
		
		function containsPoint3D(point:Point3D):Boolean;
		
	}
}