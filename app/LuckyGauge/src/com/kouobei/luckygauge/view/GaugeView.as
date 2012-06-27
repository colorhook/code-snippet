package com.kouobei.luckygauge.view {
	import com.kouobei.luckygauge.model.ModelLocator;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	

	/**
	 * ...
	 * @author 正邪
	 */
	public class GaugeView extends Gauge_design{
		
		
		protected var model:ModelLocator ;
		private var _runEnabled:Boolean = false;
		
		public function GaugeView() {
			initializeModel();
			intitializeView();
		}
		
		private function initializeModel():void {
			model = ModelLocator.getInstance();
		}
		
		public function set runEnabled (value:Boolean):void {
			_runEnabled = value;
			runButton.mouseEnabled= runButton.useHandCursor= value;
		}
		public function get runEnabled ():Boolean {
			return _runEnabled;
		}
		private function intitializeView():void {
			this.x = -125;
		
			runButton.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			runButton.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			runButton.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		
		private function onRollOver(e:*):void{
			if(model.playing||!runEnabled){
				return;
			}
			runButtonMC.gotoAndPlay('over_state');
		}
		private function onRollOut(e:*):void{
			if(model.playing||!runEnabled){
				return;
			}
			runButtonMC.gotoAndStop('stop_state');
		}
		private function onMouseClick(e:*):void{
			if(model.playing||!runEnabled){
				onRollOut(null);
				return;
			}
			runButtonMC.gotoAndPlay('play_state');
			runEnabled = false;
		}
		
		public function reset():void {
			runButton.mouseEnabled = true;
			runButtonMC.gotoAndStop('stop_state');
			clearAllEffects();
		}
		

		/**
		 * 
		 * @param	areaIndex 0~5;
		 */
		protected var currentBlinkMC:MovieClip;


		public function startBlink(areaIndex:int):void {
			if (currentBlinkMC != null) {
				stopBlink();
			}
			if (areaIndex < 0 || areaIndex > 5) {
				return;
			}
			currentBlinkMC = [h1, h2, h3, h4, h5, h6][areaIndex];
			currentBlinkMC.gotoAndPlay('start');
		}
		
		protected var effectArr:Array = [];
		public function set pRotation(rotation:Number):void {
			var pointer:*= pointer_layer.pointer;
			
			pointer.rotation+=rotation;
			
			var tempArr:Array=[];
			for(var i:int=0, l:int=this.effectArr.length; i < l; i++){
				var item:*=this.effectArr[i];
				item.alpha-=0.005;
				if(item.alpha<0.1){
					item.parent.removeChild(item);
					tempArr.push(item);
				}
			}
			for(i=0, l=tempArr.length; i < l; i++){
				var m:*=tempArr[i];
				var index:int=this.effectArr.indexOf(m);
				this.effectArr.splice(index,1)
			}
			
			if(rotation<12){
				return;
			}else{
				var p:PointerCls = new PointerCls;
				p.alpha=0.2;
				p.x=pointer.x;
				p.y=pointer.y;
				p.rotation=pointer.rotation;
				pointer_layer.addChildAt(p,0);
				effectArr.push(p);
			}
		}
		public function clearAllEffects():void {
			for(var i:int=0, l:int=this.effectArr.length; i < l; i++){
				var item:*=this.effectArr[i];
				item.parent.removeChild(item);
			}
			this.effectArr.length = 0;
		}
		public function get pRotation() :Number{
			return pointer_layer.pointer.rotation;
		}
		/**
		 * stop blink
		 */
		public function stopBlink():void {
			if (currentBlinkMC) {
				currentBlinkMC.gotoAndPlay('stop');
				currentBlinkMC = null;
			}
		}
		
		public function updateAvaiableCount(count:String):void {
			var textField:TextField = TextField(panel_user.count_tf);
			var textFormat:TextFormat = textField.getTextFormat();
			var smallSize:int = 18;
			var largeSize:int = 22;
			if (count.length >= 3 && textFormat.size != smallSize) {
				textFormat.size = smallSize;
				textField.defaultTextFormat = textFormat;
				
				textField.setTextFormat(textFormat);
				textField.y = 40;
			}else if (count.length <= 2 && textFormat.size != largeSize) {
				textFormat.size = largeSize;
				textField.defaultTextFormat = textFormat;
				
				textField.setTextFormat(textFormat);
				textField.y = 36;
			}
			panel_user.count_tf.text = count;
		}
	}
}