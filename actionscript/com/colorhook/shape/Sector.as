package com.colorhook.shape{

	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;


	public class Sector extends BaseShape {

		private var _radius:Number;
		private var _beginAngle:Number;
		private var _angle:Number;

		private var TO_DEGREE:Number=Math.PI/180;
		private var TO_RADIUS:Number=180/Math.PI;

		public function Sector(radius:Number=100,a:Number=-60,ba:Number=-90,drawStyle:DrawStyle=null) {
			this._radius=radius;
			this._beginAngle=ba%360;
			if (a>360) {
				a=360;
			} else if (a<-360) {
				a=-360;
			}
			this._angle=a;
			super(drawStyle);
		}
		
		protected override function draw():void {
			this.graphics.moveTo(0,0);
			var startCirclePoint:*=getPointFromAngle(_beginAngle);
			this.graphics.lineTo(startCirclePoint.x,startCirclePoint.y);
			var nextCirclePoint:*;
			var fix:Number=_angle>0?1:-1;
			var totalAngle:Number=Math.abs(_angle);
			
			for (var i:Number=0; i<totalAngle; i+=0.05) {
				nextCirclePoint=getPointFromAngle(_beginAngle+fix*i);
				this.graphics.lineTo(nextCirclePoint.x,nextCirclePoint.y);
			}
			this.graphics.endFill();
		}
		
		private function getPointFromAngle(angle:Number):* {
			var result:*={x:0,y:0};
			result.x=-Math.sin(angle*TO_DEGREE)*_radius;
			result.y=Math.cos(angle*TO_DEGREE)*_radius;
			return result;
		}
		
		public function get radius():Number {
			return _radius;
		}
		
		public function set radius(value:Number):void {
			if (value>0) {
				_radius=value;
				styleChanged();
			}
		}
		public function get angle():Number {
			return _angle;
		}
		public function set angle(value:Number):void {
			if (value>360) {
				value=360;
			} else if (value<-360) {
				value=-360;
			}
			_angle=value;
			styleChanged();
		}
		public function get beginAngle():Number {
			return _beginAngle;
		}
		public function set beginAngle(value:Number):void {
			_beginAngle=value%360;
			styleChanged();
		}
	}
}