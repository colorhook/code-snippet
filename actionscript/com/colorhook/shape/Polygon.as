package com.colorhook.shape{
	
	import flash.geom.Point;
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;
	
	public class Polygon extends BaseShape{
		
		private var _points:uint;
		private var _radius:Number;
		
		public function  Polygon(points:uint=3,radius:Number=50,drawStyle:DrawStyle=null){
			this._points=points;
			this._radius=radius;
			super(drawStyle);
		}
		
		protected override function draw():void{
			if(_points<2){
				throw new Error("the poins is too small");
				return;
			}
			var angle=2*Math.PI/_points;
			var edge:Number=2*_radius*Math.abs(Math.sin(Math.PI/2-angle/2));
			
			graphics.moveTo(0,-edge);
			for(var i=1;i<_points;i++){
				var p:Point=Point.polar(edge,-Math.PI/2+angle*i);
				graphics.lineTo(p.x,p.y);
			}
			graphics.endFill();
		}
		public function get radius():Number{
			return _radius;
		}
		public function set radius(value:Number):void{
			if(value<0) value=0;
			_radius=value;
			styleChanged();
		}
		public function get points():uint{
			return _points;
		}
		public function set points(value:uint):void{
			 if(value>1000){
				value=1000;
			}
			_points=value;
			styleChanged();
		}
	
	}
}