package com.colorhook.managers.toolTipClasses{
	
	public class HTMLToolTip extends ToolTip implements IToolTip{
		
		public function HTMLToolTip(){
			super();
		}
		
		override public function set text(value:String):void{
			textField.htmlText=value;
			invalidateProperties();
		}
		
	}
}