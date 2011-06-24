package com.colorhook.shape{
	

	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;
	
	public class Circle extends BaseShape{
		
		private var _radius:Number;
		
		public function  Circle(radius:Number=100,drawStyle:DrawStyle=null){
			this._radius=radius;
			super(drawStyle);
		}
		
		protected override function draw():void{
			this.graphics.drawCircle(0,0,_radius-tickness);
		}
		
		public function set radius(value){
			if(value>0){
				_radius=value;
				styleChanged();
			}
		}
		public function get radius():Number{
			return _radius;
		}
	}
}