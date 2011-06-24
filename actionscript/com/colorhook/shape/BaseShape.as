package com.colorhook.shape{

	 
	import flash.display.Sprite;

	import com.colorhook.shape.DrawStyle;
	import com.colorhook.shape.FrameCallLater;
	
	
	/**
	 * BaseShape
	 * <p>
	 * BaseShape is the basic class of all shapes.
	 * </p>
	 * 
	 * @author colorhook
	 * @version 1.0
	 */
	
	public class BaseShape extends Sprite {

		
		//DrawStyle indicate line style and fill style.
		private var _drawStyle:DrawStyle;
		
		//NextFrameCallLater is a class to call method at next frame.
		protected var frameCallLater:FrameCallLater;

		/**
		 *  Constructor.
		 */
		public function BaseShape(drawStyle:DrawStyle=null) {
			if (drawStyle==null) {
				drawStyle=new DrawStyle();
			}
			this._drawStyle=drawStyle;
			frameCallLater=new FrameCallLater(this);
			setupDraw();
		}
		
		
		
		private function setupDraw():void {
			updateGraphic();
			draw();
		}
		
		/**
		 *The details of how to draw the shape.
		 *different shape use different logic.
		 */
		protected function draw():void {
			
		}
		
		/**
		 *	set the line style and fill style.
		 */
		private function updateGraphic():void {
			this.graphics.lineStyle(_drawStyle.tickness,_drawStyle.borderColor,_drawStyle.borderAlpha);
			this.graphics.beginFill(_drawStyle.fillColor,_drawStyle.fillAlpha);
		}
		/**
		 *  redraw the shape
		 *  if you set autoRedraw to false,please call this method when the all styles you want to change has changed.
		 */
		public function redraw():void {
			graphics.clear();
			updateGraphic();
			draw();
		}
		/**
		 *  call it in the subclasses when a style changed.
		 */
		protected function styleChanged():void {
			callLater(redraw);
		}
		
		/**
		 *	call a Function at next frame.
		 */
		protected function callLater(fun:Function):void{
			frameCallLater.call(fun);
		}
		
		/**
		 *  get and set drawStyle
		 */
		public function get drawStyle():DrawStyle {
			return _drawStyle;
		}
		
		public function set drawStyle(value:DrawStyle):void {
			_drawStyle=value;
			styleChanged();
		}
		
		/**
		 *  get and set tickness
		 */
		public function get tickness():Number {
			return _drawStyle.tickness;
		}
		
		public function set tickness(value:Number):void {
			if (value>=0) {
				_drawStyle.tickness=value;
				styleChanged();
			}
		}
		
		/**
		 *  get and set borderColor
		 */
		public function get borderColor():uint {
			return _drawStyle.borderColor;
		}
		
		public function set borderColor(value:uint):void {
			_drawStyle.borderColor=value;
			styleChanged();
		}
		
		/**
		 *  get and set borderAlpha
		 */
		public function get borderAlpha():Number {
			return _drawStyle.borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void {
			value=value>1?1:value;
			value=value<0?0:value;
			_drawStyle.borderAlpha=value;
			styleChanged();
		}
		/**
		 *  get and set fillColor
		 */
		public function get fillColor():uint {
			return _drawStyle.fillColor;
		}
		
		public function set fillColor(value:uint):void {
			_drawStyle.fillColor=value;
			styleChanged();
		}
		
		/**
		 *  get and set fillAlpha
		 */
		public function get fillAlpha():Number {
			return _drawStyle.fillAlpha;
		}
		
		public function set fillAlpha(value:Number):void {
			value=value>1?1:value;
			value=value<0?0:value;
			_drawStyle.fillAlpha=value;
			styleChanged();
		}

	}
}