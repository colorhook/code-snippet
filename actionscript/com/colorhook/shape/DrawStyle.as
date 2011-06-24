package com.colorhook.shape{

	import flash.display.Shape;

	import com.colorhook.shape.DrawStyle;
	
	/**
	 *  DrawStyle
	 * 
	 */ 
	public class DrawStyle{
		private var _tickness:Number;
		private var _borderColor:uint;
		private var _borderAlpha:Number;
		private var _fillColor:uint;
		private var _fillAlpha:Number;
		
		public function DrawStyle(){
			_tickness=1;
			_borderColor=0x000000;
			_borderAlpha=1;
			_fillColor=0x0295D2
			_fillAlpha=1;
		}
		
		public function get tickness():Number {
			return _tickness;
		}
		public function set tickness(value:Number):void {
			if (value>=0) {
				_tickness=value;
			}
		}
		
		public function get borderColor():uint {
			return _borderColor;
		}
		
		public function set borderColor(value:uint):void {
			_borderColor=value;
		}
		
		public function get borderAlpha():Number {
			return _borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void {
			_borderAlpha=(value<0)?0:(value>1?1:value);
		}
		
		public function get fillColor():uint {
			return _fillColor;
		}
		
		public function set fillColor(value:uint):void {
			_fillColor=value;
		}
		
		public function get fillAlpha():Number {
			return _fillAlpha;
		}
		
		public function set fillAlpha(value:Number):void {
			_fillAlpha=(value<0)?0:(value>1?1:value);
		}

	}
}