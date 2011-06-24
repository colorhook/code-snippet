package com.colorhook.lite3d.geom{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */

	public class Point3D {
		
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public static var toDEGREES :Number = 180/Math.PI;
		public static var toRADIANS :Number = Math.PI/180;
		 
		public function Point3D(x:Number=0,y:Number=0,z:Number=0) {
			this.x=x;
			this.y=y;
			this.z=z;
		}
		
		public function reset(newx:Number = 0, newy:Number = 0, newz:Number = 0):void {
			x=newx;
			y=newy;
			z=newz;
		}
		

		
		public function clone():Point3D {
			return new Point3D(x,y,z);
		}
		
		public function copyFrom(v:Point3D):void {
			x=v.x;
			y=v.y;
			z=v.z;
		}
		
		public function copyTo(v:Point3D):void {
			v.x=x;
			v.y=y;
			v.z=z;
		}
		
		public function equals(v:Point3D):Boolean {
			return x == v.x && y == v.y && z == v.z;
		}
		
		public function plus(v:Point3D):void {
			x+= v.x;
			y+= v.y;
			z+= v.z;
		}
		
		public function plusNew(v:Point3D):Point3D {
			return new Point3D(x + v.x,y + v.y,z + v.z);
		}
		
		public function minus(v:Point3D):void {
			x-= v.x;
			y-= v.y;
			z-= v.z;
		}
		
		public function minusNew(v:Point3D):Point3D {
			return new Point3D(x - v.x,y - v.y,z - v.z);
		}
		
		public function negate():void {
			x=- x;
			y=- y;
			z=- z;
		}
		
		public function negateNew(v:Point3D):Point3D {
			return new Point3D(- x,- y,- z);
		}
		
		/**
		 *	缩放向量
		 */
		public function scale(s:Number):void {
			x*= s;
			y*= s;
			z*= s;
		}
		
		/**
		 *	返回一个新的缩放向量
		 */
		public function scaleNew(s:Number):Point3D {
			return new Point3D(x * s,y * s,z * s);
		}
		
		/**
		 *	获得该向量的模
		 */
		public function get modulo():Number {
			return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
		}
		
		/**
		 *	设置该向量的模
		 */
		public function set  module(len:Number):void {
			var r:Number=this.modulo;
			if (isNaN(r)) {
				x=len;
			} else {
				scale(len / r);
			}
		}
		
		/**
		 * Normalize.
		 */
		public function normalize():void{
			var mod:Number = Math.sqrt( this.x*this.x + this.y*this.y + this.z*this.z );
			if( mod != 0 && mod != 1){
				mod = 1 / mod; 
				this.x *= mod;
				this.y *= mod;
				this.z *= mod;
			}
		}
	
		/**
		 *	与另一个Point3D进行点积运算
		 */
		public function dot(v:Point3D):Number {
			return x * v.x + y * v.y + z * v.z;
		}
		
		/**
		 *	与另一个Point3D进行叉积运算
		 */
		public function cross(v:Point3D):Point3D {
			var cx:Number=y * v.z - z * v.y;
			var cy:Number=z * v.x - x * v.z;
			var cz:Number=x * v.y - y * v.x;
			return new Point3D(cx,cy,cz);
		}
		
		public function getPerspective(viewDist:Number=300):Number {
			var total=z + viewDist;
			return viewDist / total;
		}

		public function persProject(p:*=null):void {
			if (p == null || isNaN(p)) {
				p=getPerspective();
			}
			x*= p;
			y*= p;
			z=0;
		}
		public function persProjectNew(p:*=null):Point3D {
			if (p == null || isNaN(p)) {
				p=getPerspective();
			}
			return new Point3D(p * x,p * y,0);

		}
		
		public function rotateX(angle:Number):void {
			var ca=cosD(angle);
			var sa=sinD(angle);
			var tempY=y * ca - z * sa;
			var tempZ=y * sa + z * ca;
			y=tempY;
			z=tempZ;
		}

		public function rotateXTrig(ca:Number,sa:Number):void {
			var tempY=y * ca - z * sa;
			var tempZ=y * sa + z * ca;
			y=tempY;
			z=tempZ;
		}
		
		public function rotateY(angle:Number):void {
			var ca:Number=cosD(angle);
			var sa:Number=sinD(angle);
			var tempX:Number=x * ca + z * sa;
			var tempZ:Number=x * - sa + z * ca;
			x=tempX;
			z=tempZ;
		}

		public function rotateYTrig(ca:Number,sa:Number):void {
			var tempX:Number=x * ca + z * sa;
			var tempZ:Number=x * - sa + z * ca;
			x=tempX;
			z=tempZ;
		}


		public function rotateZ(angle:Number):void {
			var ca:Number=cosD(angle);
			var sa:Number=sinD(angle);
			var tempX:Number=x * ca - y * sa;
			var tempY:Number=x * sa + y * ca;
			x=tempX;
			y=tempY;
		}


		public function rotateZTrig(ca:Number,sa:Number):void {
			var tempX:Number=x * ca - y * sa;
			var tempY:Number=x * sa + y * ca;
			x=tempX;
			y=tempY;
		}

		public function rotateXY(a:Number,b:Number):void {
			var ca=cosD(a);
			var sa=sinD(a);
			var cb=cosD(b);
			var sb=sinD(b);
			// x-axis rotation
			var rz:Number=y * sa + z * ca;
			y=y * ca - z * sa;
			// y-axis rotation
			z=x * - sb + rz * cb;
			x=x * cb + rz * sb;
		}

		public function rotateXYTrig(ca:Number,sa:Number,cb:Number,sb:Number):void {
			// x-axis rotation
			var rz:Number=y * sa + z * ca;
			y=y * ca - z * sa;
			// y-axis rotation
			z=x * - sb + rz * cb;
			x=x * cb + rz * sb;
		}

		public function rotateXYZ(a:Number,b:Number,c:Number):void {
			var ca:Number=cosD(a);
			var sa:Number=sinD(a);
			var cb:Number=cosD(b);
			var sb:Number=sinD(b);
			var cc:Number=cosD(c);
			var sc:Number=sinD(c);
			// x-axis rotation
			var ry:Number=y * ca - z * sa;
			var rz:Number=y * sa + z * ca;
			// y-axis rotation
			var rx:Number=x * cb + rz * sb;
			z=x * - sb + rz * cb;
			// z-axis rotation
			x=rx * cc - ry * sc;
			y=rx * sc + ry * cc;
		}


		public function rotateXYZTrig(ca:Number,sa:Number,cb:Number,sb:Number,cc:Number,sc:Number):void {
			// x-axis rotation
			var ry:Number=y * ca - z * sa;
			var rz:Number=y * sa + z * ca;
			// y-axis rotation
			var rx:Number=x * cb + rz * sb;
			z=x * - sb + rz * cb;
			// z-axis rotation
			x=rx * cc - ry * sc;
			y=rx * sc + ry * cc;
		}
		
		
		public function toString():String {
			return "x:" + x + "    y:" + y + "    z:" + z;
		}
		

		private function cosD(angle:Number):Number {
			return Math.cos(angle * Math.PI / 180);
		}
		
		private function sinD(angle:Number):Number {
			return Math.sin(angle * Math.PI / 180);
		}

		/**
		*静态方法--------------------------------------
		*/


		/**
		 * 静态方法，加运算
		 */
		public static  function add(v:Point3D,w:Point3D):Point3D {
			return new Point3D(v.x + w.x,v.y + w.y,v.z + w.z);
		}

		/**
		 * 静态方法，减运算
		 */
		public static  function sub(v:Point3D,w:Point3D):Point3D {
			return new Point3D(v.x - w.x,v.y - w.y,v.z - w.z);
		}

		/**
		 * 静态方法，返回点积
		 */
		public static  function dot(v:Point3D,w:Point3D):Number {
			return (v.x * w.x + v.y * w.y + w.z * v.z);
		}

		/**
		 * 静态方法，返回叉积
		 */
		public static  function cross(v:Point3D,w:Point3D):Point3D {
			return new Point3D(w.y * v.z - w.z * v.y,w.z * v.x - w.x * v.z,w.x * v.y - w.y * v.x);
		}

		/**
		 * 静态方法，返回原点
		 */
		static public  function get ZERO():Point3D {
			return new Point3D(0,0,0);
		}
		
		static public function angleBetween(v1:Point3D,v2:Point3D):Number{
			var dotValue=Point3D.dot(v1,v2);
			if(dotValue==0){
				return Math.PI/2;
			}
			var temp=v1.modulo+v2.modulo-Point3D.add(v1,v2).modulo;
			return Math.acos(temp/2*dotValue);
		}
	}
}