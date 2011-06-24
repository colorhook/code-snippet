package com.colorhook.shape{
	
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;
	
	public class Ring extends BaseShape{
		
		private var _radius:Number;
		private var _border:Number;
		
		public static var PRECISION:Number=100;

		public function Ring(radius:Number=30,border:Number=5,drawStyle:DrawStyle=null):void{
			this._radius=radius;
			this._border=border;
			super(drawStyle);
		}
		
		protected override function draw():void{
			var i:int;
			var smallRadius:Number=_radius;
			var bigRadius:Number=_radius+_border;
			var angle:Number;
			
			this.graphics.moveTo(smallRadius,0);
			for(i=0;i<PRECISION;i++){
			    angle=2*(Math.PI/PRECISION)*i;
			    this.graphics.lineTo(smallRadius*Math.cos(angle),-smallRadius*Math.sin(angle));
			}
			this.graphics.lineTo(smallRadius,0);
			this.graphics.moveTo(bigRadius,0);
			for(i=0;i<PRECISION;i++){
			    angle=2*(Math.PI/PRECISION)*i;
			    this.graphics.lineTo(bigRadius*Math.cos(angle),-bigRadius*Math.sin(angle));
			}
			this.graphics.lineTo(bigRadius,0);
			this.graphics.endFill();
		}
		
		public function get radius():Number{
			return _radius;
		}
		
		public function set radius(value:Number):void{
			if(value>0){
				_radius=value;
				styleChanged();
			}
		}
		
		public function get border():Number{
			return _border;
		}
		public function set border(value:Number):void{
			if(value>0){
				_border=value;
				styleChanged();
			}
		}
	}
}
			