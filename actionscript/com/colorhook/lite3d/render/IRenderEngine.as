package com.colorhook.lite3d.render{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */

	import com.colorhook.lite3d.scene.IScene3D;
	import com.colorhook.lite3d.view.IView3D;
	import com.colorhook.lite3d.camera.ICamera3D;
	
	public interface IRenderEngine{

		function render(scene:IScene3D,camera:ICamera3D,view:IView3D):void;
		
	}
}