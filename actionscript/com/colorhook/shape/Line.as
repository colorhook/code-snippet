package com.colorhook.shape{
	
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;
	
	public class Line extends BaseShape{
		
		private var _length:Number;
		
		public function Line(len:Number=100,drawStyle:DrawStyle=null):void{
			this._length=len;
			super(drawStyle);
		}
		
		protected override function draw():void{
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(_length,0);
		}
		
		public function get length():Number{
			return _length;
		}
		
		public function set length(value:Number):void{
			if(value>0){
				_length=value;
				styleChanged();
			}
		}
		
		public function get color():uint{
			return borderColor;
		}
		public function set color(value:uint):void{
			borderColor=value;
		}
	}
}
			