package com.colorhook.utils{

	import flash.geom.Point;
	
	
	/**
	 * @author colorhook
	 * @version 1.0
	 */
	 
	public class PointUtil {

		static public  var toDEGREES :Number = 180/Math.PI;
		static public  var toRADIANS :Number = Math.PI/180;

		
		public static function offsetOrigin(p1:Point,base:Point):Point {
			var result=p1.clone();
			result.offset(-base.x,-base.y);
			return result;
		}
		/**
		 *以原点为中心旋转angle度后的新点
		 */
		public static function rotate(p:Point,angle:Number):Point {
			var ca = Math.cos(angle*toRADIANS);
			var sa =  Math.sin (angle*toRADIANS);
			return new Point(p.x * ca - p.y * sa,p.x * sa + p.y * ca);
		}
		/**
		 *以base为中心旋转angle度后的新点
		 */
		public static function rotateBy(p:Point,angle:Number,base:Point):Point {
			var temp:Point=offsetOrigin(p,base);
			temp=rotate(temp,angle);
			temp.offset(base.x,base.y);
			return temp;
		}
		
		/**
		 *原点到P形成的向量的斜角
		 */
		public static function getOblique(p:Point):Number {
			var cosAngle = p.x / p.length;
			if (isNaN(cosAngle)) {
				return 0;
			}
			var fix:Number=p.y<0?-1:1;
			return Math.acos(cosAngle) * toDEGREES*fix;
		}
		/**
		 *base到P形成的向量的斜角
		 */
		public static function getObliqueBy(p:Point,base:Point):Number {
			var temp:Point=offsetOrigin(p,base);
			return getOblique(temp);
		}
		
		
		/**
		 *p1-原点-p2形成的带负值的夹角，顺时针为正
		 */
		public static function getAngle(p1:Point,p2:Point):Number {
			return getOblique(p1)-getOblique(p2);
		}
		
		/**
		 *p1-base-p2形成的带负值的夹角，顺时针为正
		 */
		public static function getAngleBy(p1:Point,p2:Point,base:Point):Number {
			return getObliqueBy(p1,base)-getObliqueBy(p2,base)
		}
		
	}
}