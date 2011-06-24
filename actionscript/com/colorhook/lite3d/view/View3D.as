package com.colorhook.lite3d.view{
	
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
	import com.colorhook.lite3d.camera.ICamera3D;
	import com.colorhook.lite3d.camera.Camera3D;
	import com.colorhook.lite3d.scene.IScene3D;
	import com.colorhook.lite3d.scene.Scene3D;
	import com.colorhook.lite3d.render.IRenderEngine;
	import com.colorhook.lite3d.render.RenderEngine;
	
	public class View3D extends Sprite implements IView3D{
		
		protected var $scene:IScene3D;
		protected var $camera:ICamera3D;
		
		protected var $renderer:IRenderEngine;
		protected var $pointMap:Dictionary;

		
		public function View3D():void{
			initialize();
		}
		
		protected function initialize():void{
			$scene=new Scene3D();
			$camera=new Camera3D()
			$renderer=new RenderEngine;
			$pointMap=new Dictionary(true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		override public function addChild(child:DisplayObject):DisplayObject{
			var point:Point3D=$scene.addPoint3D();
			$pointMap[child]=point;
			return super.addChild(child);
		}
		
		 override public function removeChild(child:DisplayObject):DisplayObject{
			 $scene.removePoint3D($pointMap[child]);
			 delete $pointMap[child];
			 return super.removeChild(child);
		}
		
		 override public function addChildAt(child:DisplayObject,index:int):DisplayObject{
			return addChild(child);
		 }
		
		override public function removeChildAt(index:int):DisplayObject{
			return removeChild(getChildAt(index));
		}
	
		//--------------------------------------------------------------------------
		//
		//  Interface Methods
		//
		//--------------------------------------------------------------------------
		
		public function getAllChildren():Array{
			var result=[];
			for(var item in $pointMap){
				result.push(item);
			}
			return result;
		}
		
		public function getChildPoint3D(child:DisplayObject):Point3D{
			return $pointMap[child];
		}
		
		public function setChildPoint3D(child:DisplayObject,point:Point3D=null):void{
			$scene.removePoint3D(getChildPoint3D(child));
			if(!point) point=Point3D.ZERO;
			$pointMap[child]=$scene.addPoint3D(point);
		}
		
		public function set scene(value:IScene3D):void{
			this.$scene=value;
		}
		
		
		
		public function get scene():IScene3D{
			return this.$scene;
		}
		
		public function set camera(value:ICamera3D):void{
			this.$camera=value;
		}
		
		public function get camera():ICamera3D{
			return this.$camera;
		}
		
		public function set renderer(value:IRenderEngine):void{
			this.$renderer=value;
		}
		
		public function get renderer():IRenderEngine{
			return this.$renderer;
		}
		
		public function setChildDepth(child:DisplayObject,value:Number):void{
			setChildIndex(child,value);
		}
		
		public function render():void{
			$renderer.render($scene,$camera,this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods: Access to overridden methods of base classes
		//
		//--------------------------------------------------------------------------
		final protected function $addChild(child:DisplayObject):DisplayObject{
			return super.addChild(child);
		}
		
		 final protected function $removeChild(child:DisplayObject):DisplayObject{
			return super.removeChild(child);
		}
		
		 final protected function $addChildAt(child:DisplayObject,index:int):DisplayObject{
			return super.addChildAt(child,index);
		}
		
		final protected function $removeChildAt(index:int):DisplayObject{
			return super.removeChildAt(index);
		}
	}
}