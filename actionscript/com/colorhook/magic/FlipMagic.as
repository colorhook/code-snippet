 package com.colorhook.magic{

	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	import com.colorhook.magic.IMagic;
	import com.colorhook.magic.MagicEvent;

	public class FlipMagic extends EventDispatcher implements IMagic {
		
		private var lrx:Number;
		private var lry:Number;
		private var _target:DisplayObject;
		private var showing:Boolean;
		public var rx:Number;
		public var ry:Number;

		public function FlipMagic(ta:DisplayObject,rx:Number=720,ry:Number=0) {
			this._target=ta;
			this.rx=rx;
			this.ry=ry;
			this.showing=false;
		}
		public function show():void {
			lrx=rx;
			lry=ry;
			showing=true;
			_target.addEventListener(Event.ENTER_FRAME,loop);
			dispatchEvent(new MagicEvent(MagicEvent.SHOW));
		}
		public function clear():void {
			if (showing) {
				lrx=lry=0;
			}
		}
		private function loop(e:Event) {
			lrx-= 0.1 * lrx;
			lry-= 0.1 * lry;
			if (Math.abs(Math.max(lrx,lry)) < 0.5) {
				lrx=0;
				lry=0;
				showing=false;
				e.target.removeEventListener(Event.ENTER_FRAME,loop);
				dispatchEvent(new MagicEvent(MagicEvent.CLEAR));
			}
			e.target.transform.colorTransform=getBrightness(Math.max(lrx,lry) % 360);
			e.target.scaleX=Math.cos(Math.PI * lrx / 180);
			e.target.scaleY=Math.cos(Math.PI * lry / 180);
			e.target.filters=new Array(new BlurFilter(Math.abs(lrx) / 50,Math.abs(lry) / 50));
		}
		private function getBrightness(b:Number):ColorTransform {
			var _bright:Number;
			if (0 <= b && b <= 90) {
				_bright=b / 90 * 256;
			} else if (90 < b && b <= 180) {
				_bright=(b - 90) / 90 * 64;
			} else {
				_bright=0;
			}
			return new ColorTransform(1,1,1,1,_bright,_bright,_bright);

		}
		public function set target(t:DisplayObject):void {
			if (showing) {
				_target.removeEventListener(Event.ENTER_FRAME,loop);
			}
			_target=target;
		}
		public function get target():DisplayObject {
			return _target;
		}
	}
}