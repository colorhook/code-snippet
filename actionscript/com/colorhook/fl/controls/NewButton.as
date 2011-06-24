package com.colorhook.fl.controls{
	
	import flash.display.Sprite;
	
	import fl.core.UIComponent;
	import fl.core.InvalidationType
	
	public class NewButton extends UIComponent{
		
		protected var background:Sprite;
		
		private static var defaultStyles:Object={
			'backgroundColor':0x333333
		}
		
		public static function getStyleDefinition():Object{
			return defaultStyles;
		}
		
		public function NewButton(){
			super();

		}
		
		override protected function configUI():void{
			super.configUI();
			background=new Sprite;
			addChild(background);
			drawBackground();
		}
		
		protected function drawBackground():void{
			var bgColor:uint=getStyleValue('backgroundColor') as uint;
			background.graphics.beginFill(bgColor);
			background.graphics.drawRect(0,0,width,height);
		}
		
		
		override protected function draw():void{
			if(isInvalid(InvalidationType.STYLES,InvalidationType.SIZE)){
				drawBackground();
			}
			super.draw();
		}
		
		
	}
}