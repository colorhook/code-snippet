package com.colorhook.shape{
	
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;

	public class Ellipse extends BaseShape{
		
		private var _ellipseWidth:Number;
		private var _ellipseHeight:Number;
		
		public function Ellipse(w:Number=100,h:Number=100,drawStyle:DrawStyle=null){
			this._ellipseWidth=w;
			this._ellipseHeight=h;
			super(drawStyle);
		}
		
		protected override function draw():void{
			this.graphics.drawEllipse(0,0,_ellipseWidth-tickness,_ellipseHeight-tickness);
		}
		
		public function get ellipseWidth():Number{
			return _ellipseWidth;
		}
		public function set ellipseWidth(value:Number):void{
			_ellipseWidth=value;
			styleChanged();
		}
		public function get ellipseHeight():Number{
			return _ellipseHeight;
		}
		public function set ellipseHeight(value:Number):void{
			_ellipseHeight=value;
			styleChanged();
		}

	}
}