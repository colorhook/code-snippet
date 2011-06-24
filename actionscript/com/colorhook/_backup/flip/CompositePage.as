package colorsprite.flip{

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	import colorsprite.utils.PointUtil;

	/**
	*基于xml文件的翻页as3类
	*@Modify-Date 2008-8-30
	* @author colorsprite
	*/
	
	public class CompositePage extends Sprite {

		protected var obverseSprite:Sprite;
		protected var reverseSprite:Sprite;
		protected var obversePage:FlipPage;
		protected var reversePage:FlipPage;
		private var rect:Rectangle;
		private var pageContainer:Sprite;
		private var _pageWidth:Number;
		private var _pageHeight:Number;

		private var upShade:Sprite;
		private var downShade:Sprite;
		private var obverseMask:Sprite;
		private var reverseMask:Sprite;
		private var upShadeMask:Sprite;
		private var downShadeMask:Sprite;
		private var focusPage:Sprite;
		private var focusMask:Sprite;
		private var startPosition:String;
		private var fixPoint:Point=new Point;
		private var mousePoint:Point;
		private var startPoint:Point=new Point;
		private var obverseRequest:URLRequest;
		private var reverseRequest:URLRequest;
		
		public function CompositePage(pW:Number,pH:Number) {
			this._pageWidth=pW*0.5;
			this._pageHeight=pH;
			rect=new Rectangle(0,0,pW,pH);
			init();
		}
		
		private function init():void {
			initPage();
			initShade();
			initMask();
		}
		private function initPage():void {
			pageContainer=new Sprite  ;
			obversePage=new FlipPage(this._pageWidth,this._pageHeight);
			reversePage=new FlipPage(this._pageWidth,this._pageHeight);
			obverseSprite=new Sprite  ;
			reverseSprite=new Sprite  ;
			obverseSprite.x=_pageWidth;
			obverseSprite.addChild(obversePage);
			reverseSprite.addChild(reversePage);
			pageContainer.addChild(obverseSprite);
			pageContainer.addChild(reverseSprite);
			addChild(pageContainer);
		}
		private function initShade():void {
			upShade=FlipShape.drawShadow(50,_pageHeight + _pageWidth);
			downShade=FlipShape.drawShadow(50,_pageHeight + _pageWidth);
			downShade.scaleX=-1;
			downShade.x=upShade.x=_pageWidth;
			addChild(upShade);
			addChild(downShade);
		}
		private function initMask():void {
			var max:Number=Math.max(_pageWidth,_pageHeight);
			obverseMask=FlipShape.drawMaskRect(max * 2,0xF200F2,0.3);
			reverseMask=FlipShape.drawMaskRect(max * 2,0xFF0000,0.3);
			upShadeMask=FlipShape.drawRect(_pageWidth,_pageHeight,0xFF0000,0.3);
			downShadeMask=FlipShape.drawRect(_pageWidth * 2,_pageHeight,0xFF0000,0.2);
			upShadeMask.x=_pageWidth;
			addChild(upShadeMask);
			addChild(downShadeMask);
			addChild(obverseMask);
			addChild(reverseMask);
			obverseSprite.mask=obverseMask;
			reverseSprite.mask=reverseMask;
			upShade.mask=upShadeMask;
			downShade.mask=downShadeMask;
			obverseMask.x=rect.x + rect.width*0.5;
		}
		public function get backgroundColor():uint{
			return reversePage.backgroundColor;
		}
		public function set backgroundColor(value:uint):void{
			reversePage.backgroundColor=value;
			obversePage.backgroundColor=value;
		}
		public function executeFlip(startPos:String="topLeft"):void {
			startPosition=startPos;
			switch (startPosition) {
				case FlipStartPosition.TOP_LEFT :
					focusPage=obverseSprite;
					focusMask=obverseMask;
					obversePage.x=- rect.width*0.5;
					obversePage.y=0;
					startPoint.x=rect.x;
					startPoint.y=rect.y;
					upShadeMask.scaleX=-1;
					upShadeMask.scaleY=1;
					break;
				case FlipStartPosition.TOP_RIGHT :
					focusPage=reverseSprite;
					focusMask=reverseMask;
					reversePage.x=0;
					reversePage.y=0;
					startPoint.x=rect.x + rect.width;
					startPoint.y=rect.y;
					upShadeMask.scaleX=1;
					upShadeMask.scaleY=1;
					break;
				case FlipStartPosition.BOTTOM_LEFT :
					focusPage=obverseSprite;
					focusMask=obverseMask;
					obversePage.x=- rect.width*0.5;
					obversePage.y=- rect.height;
					startPoint.x=rect.x;
					startPoint.y=rect.y + rect.height;
					upShadeMask.scaleX=-1;
					upShadeMask.scaleY=-1;
					break;
				case FlipStartPosition.BOTTOM_RIGHT :
					focusPage=reverseSprite;
					focusMask=reverseMask;
					reversePage.x=0;
					reversePage.y=- rect.height;
					startPoint.x=rect.x + rect.width;
					startPoint.y=rect.y + rect.height;
					upShadeMask.scaleX=1;
					upShadeMask.scaleY=-1;
					break;
			}
			pageContainer.addChild(focusPage);
		}
		public function depositeFlip():void{
			executeFlip("topRight");
			render(new Point(0.1,0.1));
		}
		private function adjustPoint(p:Point,_startPos:String):Point {
			var middleUpPoint:Point=new Point(rect.x + rect.width *0.5,rect.y);
			var middleDownPoint:Point=new Point(rect.x + rect.width *0.5,rect.y + rect.height);
			var len:Number;
			var max:Number;
			if (_startPos == FlipStartPosition.TOP_LEFT || _startPos == FlipStartPosition.TOP_RIGHT) {
				len=Point.distance(middleUpPoint,p);
				max=rect.width * 0.5;
				if (len > max) {
					p=Point.interpolate(middleUpPoint,p,1 - max / len);
				}
				len=Point.distance(middleDownPoint,p);
				max=Math.sqrt(rect.height * rect.height + rect.width * rect.width *0.25);
				if (len > max) {
					p=Point.interpolate(middleDownPoint,p,1 - max / len);
				}
			} else {
				len=Point.distance(middleDownPoint,p);
				max=rect.width * 0.5;
				if (len > max) {
					p=Point.interpolate(middleDownPoint,p,1 - max / len);
				}
				len=Point.distance(middleUpPoint,p);
				max=Math.sqrt(rect.height * rect.height + rect.width * rect.width *0.25);
				if (len > max) {
					p=Point.interpolate(middleUpPoint,p,1 - max / len);
				}
			}
			
			return p;
		}
		public function getFixPoint():Point{
			return fixPoint;
		}
		public function getStartPoint():Point{
			var p:Point=new Point();
			p.x=(startPoint.x<=1)?0.5:rect.width-0.5;
			p.y=(startPoint.y<=1)?0.5:rect.height-0.5;
			return p;
		}
		public function getAimPoint():Point{
			var p:Point=new Point();
			p.x=(startPoint.x<=1)?rect.width-0.5:0.5;
			p.y=(startPoint.y<=1)?0.5:rect.height-0.5;
			return p;
		}
		public function render(p:Point):void {
			fixPoint=adjustPoint(p,startPosition);
			if(fixPoint.x<=0||fixPoint.x>=rect.width||fixPoint.y==0||fixPoint.y==rect.width){
				return;
			}
			var angle=PointUtil.getObliqueBy(fixPoint,startPoint);
			var maskPoint:Point=Point.interpolate(fixPoint,startPoint,0.5);
			focusPage.x=fixPoint.x;
			focusPage.y=fixPoint.y;
			focusPage.rotation=2 * angle;
			reverseMask.x=obverseMask.x=maskPoint.x;
			reverseMask.y=obverseMask.y=maskPoint.y;
			reverseMask.rotation=angle+180;
			obverseMask.rotation=angle+180;
			focusMask.rotation-=180;
			upShade.x=focusMask.x;
			upShade.y=focusMask.y;
			downShade.x=maskPoint.x;
			downShade.y=maskPoint.y;


			upShade.rotation=focusMask.rotation;
			downShade.rotation=focusMask.rotation;
			upShadeMask.x=focusPage.x;
			upShadeMask.y=focusPage.y;
			upShadeMask.rotation=focusPage.rotation;
		}
		public function load(obverseRequest:URLRequest,reverseRequest:URLRequest):void {
			this.obverseRequest=obverseRequest;
			this.reverseRequest=reverseRequest;
			loadObversePage();
		}
		private function loadObversePage():void {
			obversePage.addEventListener(FlipEvent.PAGE_PROGRESS,pageProgressHandler,false,0,true);
			obversePage.addEventListener(FlipEvent.PAGE_LOAD_COMPLETE,loadCompleteHandler,false,0,true);
			obversePage.addEventListener(FlipEvent.IO_ERROR,ioErrorHandler,false,0,true);
			obversePage.load(obverseRequest);
		}
		private function loadReversePage():void {
			reversePage.addEventListener(FlipEvent.PAGE_PROGRESS,pageProgressHandler,false,0,true);
			reversePage.addEventListener(FlipEvent.PAGE_LOAD_COMPLETE,loadCompleteHandler,false,0,true);
			reversePage.addEventListener(FlipEvent.IO_ERROR,ioErrorHandler,false,0,true);
			reversePage.load(reverseRequest);
		}
		private function pageProgressHandler(e:FlipEvent):void {
			dispatchEvent(new FlipEvent(FlipEvent.PAGE_PROGRESS));
		}
		private function loadCompleteHandler(e:FlipEvent):void {
			e.currentTarget.removeEventListener(FlipEvent.IO_ERROR,ioErrorHandler);
			e.currentTarget.removeEventListener(FlipEvent.PAGE_PROGRESS,pageProgressHandler);
			e.currentTarget.removeEventListener(FlipEvent.PAGE_LOAD_COMPLETE,loadCompleteHandler);
			if (e.currentTarget == obversePage) {
				loadReversePage();
			} else {
				dispatchEvent(new FlipEvent(FlipEvent.PAGE_LOAD_COMPLETE));
			}
		}
		private function ioErrorHandler(e:FlipEvent):void {
			e.currentTarget.removeEventListener(FlipEvent.PAGE_PROGRESS,pageProgressHandler);
			e.currentTarget.removeEventListener(FlipEvent.PAGE_LOAD_COMPLETE,loadCompleteHandler);
			e.currentTarget.removeEventListener(FlipEvent.IO_ERROR,ioErrorHandler);
			dispatchEvent(new FlipEvent(FlipEvent.IO_ERROR));
		}
	}
}

import flash.display.Sprite;
import flash.display.Graphics;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.geom.Matrix;
import flash.geom.Rectangle;
class FlipShape {
	public static  function drawRect(w:Number,h:Number,color:uint=0xFFFFFF,alpha:Number=1.0):Sprite {
		var sprite=new Sprite  ;
		sprite.graphics.beginFill(color,alpha);
		sprite.graphics.drawRect(0,0,w,h);
		return sprite;
	}
	public static  function drawMaskRect(halfLen,color:uint=0xFF0000,alpha:Number=1.0):Sprite {
		var sprite=new Sprite  ;
		sprite.graphics.beginFill(color,alpha);
		sprite.graphics.moveTo(0,0);
		sprite.graphics.lineTo(0,halfLen);
		sprite.graphics.lineTo(2 * halfLen,halfLen);
		sprite.graphics.lineTo(2 * halfLen,- halfLen);
		sprite.graphics.lineTo(0,- halfLen);
		sprite.graphics.lineTo(0,0);
		sprite.graphics.endFill();
		return sprite;
	}
	public static  function drawShadow(w,h,color:uint=0xFF0000,alpha:Number=1.0):Sprite {
		var s:Sprite=new Sprite  ;
		var fillType:String=GradientType.LINEAR;
		var colors:Array=[0x000000,0xFFFFFF];
		var alphas:Array=[100,0];
		var ratios:Array=[0,80];
		var matr:Matrix=new Matrix  ;
		matr.createGradientBox(50,20,0,0,0);
		var spreadMethod:String=SpreadMethod.PAD;
		s.graphics.beginGradientFill(fillType,colors,alphas,ratios,matr,spreadMethod);
		s.graphics.moveTo(0,0);
		s.graphics.lineTo(0,h);
		s.graphics.lineTo(w,h);
		s.graphics.lineTo(w,- h);
		s.graphics.lineTo(0,- h);
		s.graphics.lineTo(0,0);
		s.graphics.endFill();
		return s;
	}
}