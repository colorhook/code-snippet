package colorsprite.magic{
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.GradientType;

	import com.colorhook.magic.IMagic;
	import com.colorhook.magic.MagicEvent;

	public class ReflectionMagic extends EventDispatcher implements IMagic {

		private var _target:DisplayObject;
		private var _reflection:Bitmap;
		private var _strength:Number;
		public function ReflectionMagic(ta:DisplayObject) {
			this._target=ta;
			_strength=160;
			_reflection=new Bitmap();
		}
		public function show():void {
			var bd:BitmapData=new BitmapData(_target.width,_target.height,true,0);
			var mtx:Matrix=new Matrix;
			mtx.d=-1;
			mtx.ty=bd.height;
			bd.draw(_target,mtx);
			var width:int=bd.width;
			var height:int=bd.height;
			mtx=new Matrix  ;
			mtx.createGradientBox(width,height,0.5 * Math.PI);
			var shape:Shape=new Shape;
			shape.graphics.beginGradientFill(GradientType.LINEAR,[0,0,0],[0.4,0,0],[0,_strength,255],mtx);
			shape.graphics.drawRect(0,0,width,height);
			shape.graphics.endFill();
			var mask_bd:BitmapData=new BitmapData(width,height,true,0);
			mask_bd.draw(shape);
		
			bd.copyPixels(bd,bd.rect,new Point(0,0),mask_bd,new Point(0,0),false);
		
			_reflection.x=_target.x;
			_reflection.y=_target.height+_target.y;
			_reflection.bitmapData=bd;
			_target.parent.addChild(_reflection);
			dispatchEvent(new MagicEvent(MagicEvent.SHOW));
		}
		public function clear():void {
			_target.parent.removeChild(_reflection);
			_reflection.bitmapData.dispose();
			dispatchEvent(new MagicEvent(MagicEvent.CLEAR));
		}
		public function set strength(s:Number):void {
			if (s>=254) {
				s=254;
			} else if (s<=1) {
				s=1;
			}
			_strength=s;
		}
		public function get strength():Number {
			return _strength;

		}
		public function set target(t:DisplayObject):void {
			_target=t;
		}
		public function get target():DisplayObject {
			return _target;
		}
	}
}