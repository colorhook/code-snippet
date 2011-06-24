package colorsprite.flip{
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	
	/**
	*基于xml文件的翻页as3类
	*@Modify-Date 2008-8-30
	* @author colorsprite
	*/
	
	public class FlipPage extends Sprite {

		private var _backgroundColor:uint=0x92A25E;
		private var _pageWidth:Number;
		private var _pageHeight:Number;
		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		private var _paddingLeft:Number;
		private var _paddingRight:Number;
		private var _padding:Number;
		private var _contentWidth:Number;
		private var _contentHeight:Number;
		
		protected var _background:Shape;
		protected var loader:Loader;


		public function FlipPage(_width:Number,_height:Number):void {
			_pageWidth=_width;
			_pageHeight=_height;
			initPadding();
			init();
		}
		private function initPadding(){
			padding=0;
		}
		private function init():void {
			setBackground();
			addChild(_background);
			setLoader();
			addChild(loader);
		}
		private function setBackground():void {
			_background=new Shape();
			drawBackgound();
		}
		private function setLoader() {
			loader=new Loader() ;
			loader.x=loader.y=0;
		}
		private function drawBackgound():void {
			var g=_background.graphics;
			g.clear();
			g.beginFill(_backgroundColor);
			g.drawRect(0,0,_pageWidth,_pageHeight);
		}
		public function load(urlR:URLRequest):void {
			loader.load(urlR);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler,false,0,true);
		}
		
		public  function resetPage():void{
			var maxWidth=_pageWidth-_paddingLeft-_paddingRight;
			var maxHeight=_pageHeight-_paddingTop-_paddingBottom;
			var widthTimes:Number=_contentWidth/maxWidth;
			var heightTimes:Number=_contentHeight/maxHeight;
			var times:Number=Math.max(widthTimes,heightTimes);
			loader.width=_contentWidth/times;
			loader.height=_contentHeight/times;
			loader.x=_paddingLeft+(maxWidth-loader.width)*0.5;
			loader.y=_paddingTop+(maxHeight-loader.height)*0.5;
		}

		
		public function set backgroundColor(color:uint):void {
			_backgroundColor=color;
			drawBackgound();
		}
		public function get backgroundColor():uint {
			return _backgroundColor;
		}
		public function set padding(value:Number):void{
			if(value<0) value=0;
			_padding=_paddingLeft=_paddingRight=_paddingTop=_paddingBottom=value;
		}
		public function set paddingLeft(value:Number):void{
			if(value<0) value=0;
			_paddingLeft=value;
			
		}
		public function set paddingRight(value){
			if(value<0) value=0;
			_paddingRight=value;
		}
		public function set paddingTop(value){
			if(value<0) value=0;
			_paddingTop=value;
		}
		public function set paddingBottom(value){
			if(value<0) value=0;
			_paddingBottom=value;
		}
		private function ioErrorHandler(e:IOErrorEvent):void {
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			dispatchEvent(new FlipEvent(FlipEvent.IO_ERROR));
		}
		private function progressHandler(e:ProgressEvent):void {
			dispatchEvent(new FlipEvent(FlipEvent.PAGE_PROGRESS));
		}
		private function completeHandler(e:Event):void {
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			_contentWidth=loader.contentLoaderInfo.width;
			_contentHeight=loader.contentLoaderInfo.height;
			resetPage();
			dispatchEvent(new FlipEvent(FlipEvent.PAGE_LOAD_COMPLETE));
		}
	}
}