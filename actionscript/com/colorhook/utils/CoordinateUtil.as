package com.colorhook.utils{
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;

	public class CoordinateUtil {


		public function CoordinateUtil() {
		}

		
		public static function localToLocal(containerFrom:DisplayObject, containerTo:DisplayObject, origin:Point=null):Point {
			var point:Point = origin ? origin : new Point();
			point = containerFrom.localToGlobal(point);
			point = containerTo.globalToLocal(point);
			return point;
		}
		public static function globalMouse(_stage:Stage,stageLimited:Boolean = true):Point {
			var px:int;
			var py:int;
			var result:Point;


			px = _stage.mouseX;
			py = _stage.mouseY;

			if (stageLimited) {
				px = px < 0 ? (0) : (px > _stage.stageWidth ? (_stage.stageWidth) : (px));
				py = py < 0 ? (0) : (py > _stage.stageHeight ? (_stage.stageHeight) : (py));
			}// end if
			result = new Point(px, py);
			return result;
		}
		
	}

}