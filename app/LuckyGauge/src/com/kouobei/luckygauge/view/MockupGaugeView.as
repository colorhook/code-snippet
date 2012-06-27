package com.kouobei.luckygauge.view {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	/**
	 * ...
	 * @author 正邪
	 */
	public class MockupGaugeView extends Sprite implements IGaugeView{
		
		protected var $pointer:Sprite;
		protected var $runButton:Sprite;
		private var _runEnabled:Boolean;
		public function MockupGaugeView() {
			$pointer = new Sprite;
			var pg:Graphics = $pointer.graphics;
			pg.beginFill(0xFF3366, 1);
			pg.drawRect( -2, 0, 4, 100);
			pg.endFill();
			$pointer.x = $pointer.y = 200;
			
			$runButton = new Sprite;
			var rg:Graphics = $runButton.graphics;
			rg.beginFill(0xDD6633, 1);
			rg.drawCircle(0, 0, 30);

			rg.lineStyle(1, 0xFFFFFF);
			for (var i:int = 0; i < 5; i++) {
				var angle:Number = Math.PI*2 * i/5;
				rg.moveTo(0, 0);
				rg.lineTo(Math.sin(angle) * 30, Math.cos(angle) * 30);
			}
			rg.endFill();
			$runButton.x = $runButton.y = 200;
		
			this.addChild($pointer);
			this.addChild($runButton);
			
		}

		public function get pointer():DisplayObject {
			return $pointer;
		}
		
		public function get runButton():InteractiveObject {
			return $runButton;
		}
		
		public function get runEnabled():Boolean {
			return _runEnabled;
		}
		
		public function set runEnabled(value:Boolean):void {
			if (_runEnabled == value) {
				return;
			}
			
			_runEnabled = value;
			$runButton.mouseEnabled = value;
		}
	}
}