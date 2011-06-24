package com.colorhook.shape{
	
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;

	public class Rect extends BaseShape{
		
		private var _rectWidth:Number;
		private var _rectHeight:Number;
		
		public function Rect(w:Number=100,h:Number=100,drawStyle:DrawStyle=null){
			this._rectWidth=w;
			this._rectHeight=h;
			super(drawStyle);
		}
		
		protected override function draw():void{
			this.graphics.drawRect(0,0,_rectWidth-tickness,_rectHeight-tickness);
		}
		
		
		public function get rectWidth():Number{
			return _rectWidth;
		}
		public function set rectWidth(value:Number):void{
			_rectWidth=value;
			styleChanged();
		}
		
		public function get rectHeight():Number{
			return _rectHeight;
		}
		public function set rectHeight(value:Number):void{
			_rectHeight=value;
			styleChanged();
		}

	}
}