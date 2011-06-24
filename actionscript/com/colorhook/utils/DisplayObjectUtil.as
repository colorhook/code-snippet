package com.colorhook.utils{
	
	/**
	 * @author colorhook
	 * @version 1.1
	 */

	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	
	public class DisplayObjectUtil{
		
		/**
		 * @description position a DisplayObject with a specific width & height.
		 */
		public static function position(d:DisplayObject,width:Number,height:Number,
										surpass:Boolean=false,scaleContent:Boolean=false):void{
			if(scaleContent){
				d.width=width;
				d.height=height;
				return;
			}
			var dws:Number=width/d.width
			var dhs:Number=height/d.height;
			var scaleFactor=surpass?Math.max(dws,dhs):Math.min(dws,dhs);
			d.width=d.width*scaleFactor;
			d.height=d.height*scaleFactor;
		}
		
		/**
		 * @descrition check if a specific point of a DisplayObject is transparent.
		 */
		public static function isAlpha(sprite:DisplayObject,x:Number,y:Number,tolerance:Number=10):Boolean{
			if(tolerance<0) tolerance=0;
			var bmp:BitmapData=new BitmapData(sprite.width,sprite.height,true,0x00000000);
			bmp.draw(sprite);
			var color:uint=bmp.getPixel32(x,y);
			return Number(color.toString(16))<tolerance;
		}
		
		/**
		 * @descrition check if the mouse position of a DisplayObject is transparent.
		 */
		public static function isMouseHitAlpha(sprite:DisplayObject,tolerance:Number=10):Boolean{
			return isAlpha(sprite,sprite.mouseX,sprite.mouseY,tolerance);
		}
	}
}