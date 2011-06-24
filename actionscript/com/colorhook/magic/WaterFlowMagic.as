 package com.colorhook.magic{

	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.filters.DisplacementMapFilter;
	import flash.events.Event;

	import com.colorhook.magic.IMagic;
	import com.colorhook.magic.MagicEvent;
	
	public class WaterFlowMagic extends EventDispatcher implements IMagic {
		
		
		private var _target:DisplayObject;
		private var showing:Boolean;
		
		private var bitmapData:BitmapData;
		private var point = new Point(0, 0);
		private var dmFilter :DisplacementMapFilter;
		
		/**
		 *	@param 
		 */
		private var _speedX:Number;
		private var _speedY:Number;
		private var _baseX:Number;
		private var _baseY:Number;
		private var _numOctaves:Number;
		
		private var i:Number=1;
		private var j:Number=1;
		private var _magicWidth:Number;
		private var _magicHeight:Number;
		
		public function WaterFlowMagic(ta:DisplayObject,mw:Number=400,mh:Number=320) {
			this._target=ta;
			this.showing=false;
			_speedX=1;
			_speedY=1;
			_baseX=300;
			_baseY=30;
			_numOctaves=2
			_magicWidth=mw;
			_magicHeight=mh;
			bitmapData = new BitmapData(mw, mh, false, 0);
			dmFilter = new DisplacementMapFilter(bitmapData, point, 1, 1, 10, 50);
		}
		
		public function show():void {
			showing=true;
			_target.addEventListener(Event.ENTER_FRAME,loop,false,0,true);
			dispatchEvent(new MagicEvent(MagicEvent.SHOW));
		}
		
		public function clear():void {
			if (showing) {
				speedX=1;
				speedY=1;
				_target.filters=[];
				_target.removeEventListener(Event.ENTER_FRAME,loop);
				dispatchEvent(new MagicEvent(MagicEvent.CLEAR));
			}
		}
		



		private function loop(e:Event) {
			var offset:Point = new Point(i, j);
			bitmapData.perlinNoise(_baseX,_baseY,_numOctaves,50,false,false,1,true, [offset]);
			dmFilter.mapBitmap=bitmapData;
			_target.filters=[dmFilter];
			i+=_speedX
			j+=_speedY
		}
		
		
		
		public function get speedX():Number{
			return _speedX;
		}
		public function set speedX(value:Number):void{
			_speedX=value
		}
		public function get speedY():Number{
			return _speedY;
		}
		public function set speedY(value:Number):void{
			_speedY=value
		}
		public function get baseX():Number{
			return _baseX;
		}
		public function set baseX(value:Number):void{
			_baseX=value
		}
		public function get baseY():Number{
			return _baseY;
		}
		public function set baseY(value:Number):void{
			_baseY=value
		}
		public function get numOctaves():Number{
			return _numOctaves;
		}
		public function set numOctaves(value:Number):void{
			_numOctaves=value
		}
		
		public function get magicWidth():Number{
			return _magicWidth;
		}
		public function set magicWidth(value:Number):void{
			_magicWidth=value
		}
		public function get magicHeight():Number{
			return _magicHeight;
			bitmapData = new BitmapData(magicWidth, magicHeight, false, 0);
		}
		public function set magicHeight(value:Number):void{
			_magicHeight=value
			bitmapData = new BitmapData(magicWidth, magicHeight, false, 0);
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