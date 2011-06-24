package com.colorhook.utils{

	import flash.text.TextField;
	import flash.geom.Rectangle;
	
	/**
	 * @author colorhook
	 * @version 1.0
	 */
	 
	public class TextUtil {
		
		public static function measureTextField(textField:TextField):Rectangle{
			textField.wordWrap=false;
			textField.multiline=false;
			var textWidth:Number=textField.textWidth+6;
			var textHeight:Number=textField.textHeight+textField.getLineMetrics(0).leading+6;
			var _measuredWidth:Number;
			var _measuredHeight:Number;
			_measuredWidth=textWidth;
			//textField.width=_measuredWidth;
			_measuredHeight=textField.textHeight+textField.getLineMetrics(0).leading+6;
			return new Rectangle(0,0,_measuredWidth,_measuredHeight);
		}
		
		public static function adjustTextField(textField:TextField):void{
			var rect:Rectangle=measureTextField(textField);
			textField.width=rect.width;
			textField.height=rect.height;
		}
		
	}
}