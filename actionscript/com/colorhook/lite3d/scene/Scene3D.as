package com.colorhook.lite3d.scene{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import com.colorhook.lite3d.geom.Point3D;
	
	public class Scene3D implements IScene3D{
		

		protected var $pointMap:Dictionary;
		
		public function Scene3D():void{
			initialize();
		}
		
		protected function initialize():void{
			$pointMap=new Dictionary(true);
		}
		
		
	
		//--------------------------------------------------------------------------
		//
		//  Interface Methods
		//
		//--------------------------------------------------------------------------
		
		public function addPoint3D(point:Point3D=null):Point3D{
			if(!point) point=Point3D.ZERO;
			if(containsPoint3D(point)){
				return point;
			}
			$pointMap[point]=true;
			return point;
		}
		
		public function removePoint3D(point:Point3D):Point3D{
			if(!containsPoint3D(point)){
				return null;
			}
			delete $pointMap[point];
			return point;
		}
		
		public function containsPoint3D(point:Point3D):Boolean{
			return $pointMap[point]!=null;
		}
		
		
		
	}
}