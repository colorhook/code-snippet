package com.colorhook.lite3d.camera{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	import flash.display.DisplayObject;
	import com.colorhook.lite3d.geom.Point3D;

	
	public class Camera3D implements ICamera3D{
		
		protected var $position:Point3D;
		protected var $direction:Point3D;
		protected var $zoom:Number=1;
		protected var $fov:Number=1;

		private var _rotationX:Number=0;
		private var _rotationY:Number=0;
		private var _rotationZ:Number=0;

		private var _pitch:Number=0;
		private var _yaw:Number=0;
		private var _roll:Number=0;
		
		public function Camera3D(x:Number=0,y:Number=0,z:Number=0):void{
			$position=new Point3D(x,y,z);
			$direction=Point3D.ZERO;
		}
	
		public function get fov():Number{
			return $fov;
		}
		
		public function set fov(value:Number):void{
			if(value<0){
				value=0;
			}
			$fov=value;
			$zoom=1/Math.tan($fov/2);
		}
		
		public function get zoom():Number{
			return $zoom;
		}
		
		public function set zoom(value:Number):void{
			if(value<0){
				value=0;
			}
			$zoom=value;
			$fov=2*Math.atan(1/$zoom);
		}
		
		public function get position():Point3D{
			return $position;
		}
		
		public function set position(value:Point3D):void{
			this.$position.copyFrom(value);
		}
		
		public function get direction():Point3D{
			return $direction;
		}
		
		public function set direction(value:Point3D):void{
			this.$direction.copyFrom(value);
		}


		public function get rotationX():Number{
			return _rotationX;
		}
		
		public function set rotationX(value:Number):void{
			_rotationX=value;
		}
		
		public function get rotationY():Number{
			return _rotationY;
		}
		
		public function set rotationY(value:Number):void{
			_rotationY=value;
		}
		
		public function get rotationZ():Number{
			return _rotationZ;
		}
		
		public function set rotationZ(value:Number):void{
			_rotationZ=value;
		}

		
		public function get pitch():Number{
			return _pitch;
		}
		
		public function set pitch(value:Number):void{
			_pitch=value;
		}
		
		public function get yaw():Number{
			return _yaw;
		}
		
		public function set yaw(value:Number):void{
			_yaw=value;
		}
		
		public function get roll():Number{
			return _roll;
		}
		
		public function set roll(value:Number):void{
			_roll=value;
		}
		
		
	}
}