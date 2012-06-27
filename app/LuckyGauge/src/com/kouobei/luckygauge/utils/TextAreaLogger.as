package com.kouobei.luckygauge.utils {
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	/**
	 * ...
	 * @author 正邪
	 */
	public class TextAreaLogger extends Logger implements ILogger {
		
		protected var textArea:TextField;
		protected var container:DisplayObjectContainer;
		
		public function TextAreaLogger(target:*, container:DisplayObjectContainer) {
			super(target);
			textArea = new TextField;
			textArea.x = 400;
			textArea.height = 400;
			textArea.width = 320;
			this.container = container;
			this.container.addChild(textArea);
		}
		
		public function getTextArea():TextField {
			return textArea;
		}
		
		override protected function sendInfo(...rest):void {
			super.sendInfo(rest);
			textArea.appendText(rest.join('') + '\n');
		}
	}
}