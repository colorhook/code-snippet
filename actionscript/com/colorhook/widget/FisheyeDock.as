package com.colorhook.widget{

	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FisheyeDock extends Sprite{
		
		protected var container:Sprite;
		protected var tray:Sprite;
		
		private var _icon_min:Number=48;
		private var _icon_max:Number=96;
		private var _icon_size:Number=128;
		private var _icon_spacing:Number=2;
		private var _layout:String="bottom";


		private var _scale:Number;
		private var _trend:Number=0;
		
		private var nWidth:Number=0;
		private var xmouse:Number;
		private var ymouse:Number;

		
		private var items:Array;
		private var tempX:Array;

		public function FisheyeDock(options:*=null){
			setOptions(options);
			initialize();
		}
		
		public function setOptions(options:*=null){
			tempX=[];
			items=[];
		}
		
		public function set layout(value:String):void{
			if(_layout == value){
				return;
			}
			_layout=value;
			switch(_layout){
				case "left":
					this.rotation= 90;
					break;
				case "top":
					this.rotation= 180;
					break;
				case "right":
					this.rotation=270;
					break;
				default:
					this.rotation=0;
					break;
			}
			if(container){
				invalidate();
			}
			
		}
		
		private function initialize():void{
			var h:Number=_icon_min+2*_icon_spacing;
			var w:Number=nWidth+2*_icon_spacing;
			tray=new Sprite();
			tray.graphics.lineStyle(0, 0xcccccc, 0.8);
			tray.graphics.beginFill(0xe8e8e8, 0.5);
			tray.graphics.drawRect(0, 0, w, -h);
			tray.graphics.endFill();
			addChild(tray);
			container=new Sprite();
			addChild(container);
			layout="left"
			addEventListener(Event.ENTER_FRAME,loop);
		}
		
		private function loop(e:Event):void{
			update();
		}
		
		public function setData(items:Array):void{
			this.items=items==null?[]:items;
			invalidate();
		}
		
		public function addItem(item:DisplayObject):void{
			if(hasItem(item)){
				removeItem(item);
			}
			items.push(item);
			invalidate();
		}
		
		public function addItemAt(item:DisplayObject,n:int):void{
			if(hasItem(item)){
				removeItem(item);
			}
			items.splice(n,0,item);
			invalidate();
		}
		
		public function removeItem(item:DisplayObject):void{
			var p:int= items.indexOf(item);
			if(p!=-1){
				items.splice(p,1);
				invalidate();
			}
		}
		
		public function removeItemAt(n:int):void{
			if(n<items.length&&n>=0){
				items=items.splice(n,1);
				invalidate();
			}
		}
		
		public function hasItem(item:DisplayObject):Boolean{
			return items.indexOf(item)!= -1;
		}
		
		protected function drawIcons():void{
			destroyIcons();
			_scale = 0;
			nWidth = (items.length - 1) * _icon_spacing + items.length * _icon_min;
			var left:Number = (_icon_min - nWidth) / 2;

			for ( var i:Number = 0; i < items.length ; i++ )
			{
				var icon:Sprite = new Sprite();
				var mc:DisplayObject=items[i] as DisplayObject;
				icon.addChild(mc);
				container.addChildAt(icon, i);

				mc.y = -_icon_size /2;
				mc.rotation = -this.rotation;
				
				icon.x = tempX[i] = left + i * (_icon_min + _icon_spacing) + _icon_spacing / 2;
				icon.y = -_icon_spacing;
				icon.doubleClickEnabled=true;
				icon.mouseChildren=false;
				icon.addEventListener(MouseEvent.ROLL_OVER,onItemRollOver);
				icon.addEventListener(MouseEvent.ROLL_OUT,onItemRollOut);
				icon.addEventListener(MouseEvent.CLICK,onItemClick);
				icon.addEventListener(MouseEvent.DOUBLE_CLICK,onItemDoubleClick);
			}
		}
		
		protected function destroyIcons():void{
			var i:int=container.numChildren
			while(i--){
				var item:DisplayObject=container.removeChildAt(i);
				try{
					item.removeEventListener(MouseEvent.ROLL_OVER,onItemRollOver);
					item.removeEventListener(MouseEvent.ROLL_OUT,onItemRollOut);
					item.removeEventListener(MouseEvent.CLICK,onItemClick);
					item.removeEventListener(MouseEvent.DOUBLE_CLICK,onItemDoubleClick);
				}catch(error:Error){}
			}
		}
		
		private function onItemRollOver(event:MouseEvent):void{
			var eventNew:FisheyeDockEvent=new FisheyeDockEvent(FisheyeDockEvent.ITEM_ROLL_OVER);
			var icon=event.currentTarget as DisplayObjectContainer;
			eventNew.item=icon.getChildAt(0) as DisplayObject;
			eventNew.index=container.getChildIndex(icon);
			this.dispatchEvent(eventNew);
		}
		
		private function onItemRollOut(event:MouseEvent):void{
			var eventNew:FisheyeDockEvent=new FisheyeDockEvent(FisheyeDockEvent.ITEM_ROLL_OUT);
			var icon=event.currentTarget as DisplayObjectContainer;
			eventNew.item=icon.getChildAt(0) as DisplayObject;
			eventNew.index=container.getChildIndex(icon);
			this.dispatchEvent(eventNew);
		}
		
		private function onItemClick(event:MouseEvent):void{
			var eventNew:FisheyeDockEvent=new FisheyeDockEvent(FisheyeDockEvent.ITEM_CLICK);
			var icon=event.currentTarget as DisplayObjectContainer;
			eventNew.item=icon.getChildAt(0) as DisplayObject;
			eventNew.index=container.getChildIndex(icon);
			this.dispatchEvent(eventNew);
		}
		
		private function onItemDoubleClick(event:MouseEvent):void{
			var eventNew:FisheyeDockEvent=new FisheyeDockEvent(FisheyeDockEvent.ITEM_DOUBLE_CLICK);
			var icon=event.currentTarget as DisplayObjectContainer;
			eventNew.item=icon.getChildAt(0) as DisplayObject;
			eventNew.index=container.getChildIndex(icon);
			this.dispatchEvent(eventNew);
		}
		
		public function update():void{
			if(items.length==0){return;}
			
			var dx:Number;
			var dim:Number;
			
			// Mouse moved or Dock is between states. Update Dock.
			xmouse = this.mouseX;
			ymouse = this.mouseY;
			
			// Ensure that inflation does not change direction.
			trend = (trend == 0 ) ? (checkBoundary() ? 0.25 : -0.25) : (trend);
			_scale += trend;
			if( (_scale < 0.02) || (_scale > 0.98) ) 
			{ 
				trend = 0; 
			}
			
			// Actual scale is in the range of 0..1
			_scale = Math.min( 1, Math.max(0, _scale) );
			
			// Hard stuff. Calculating position and scale of individual icons.
			for( var i:Number = 0; i < items.length; i++) 
			{
				dx = tempX[i] - xmouse;

				dx = Math.min( Math.max(dx, - span), span);
				
				dim = _icon_min + (_icon_max - _icon_min) * Math.cos(dx * ratio) * (Math.abs(dx) > span ? 0 : 1) * _scale;
				var item:DisplayObject=container.getChildAt(i);
				item.x = tempX[i] + _scale * amplitude * Math.sin(dx * ratio);
				item.scaleX = item.scaleY = dim / _icon_size;
			}
			updateTray();
		}
		
		private function checkBoundary():Boolean{
			var buffer:Number = 4 * _scale;
			var childFirst:DisplayObject=container.getChildAt(0);
			var childLast:DisplayObject=container.getChildAt(items.length-1);
			
			return (ymouse < 0)
			&& (ymouse > -2 * _icon_spacing - _icon_min + (_icon_min - _icon_max) * _scale)
			&& (xmouse > childFirst.x - childFirst.width / 2 - _icon_spacing - buffer)
			&& (xmouse < childLast.x + childLast.width / 2 + _icon_spacing + buffer);
		}

		private function updateTray():void{
			var px:Number;
			var pw:Number;
			var childFirst:DisplayObject=container.getChildAt(0);
			var childLast:DisplayObject=container.getChildAt(items.length-1);

			px = childFirst.x - childFirst.width / 2 - _icon_spacing;
			pw = childLast.x + childLast.width / 2 + _icon_spacing;
			tray.x = px;
			tray.width = pw - px;
		}
		
		protected function invalidate():void{
			drawIcons();
			update();
		}
		
		private function get amplitude():Number{
			return 2 * (_icon_max - _icon_min + _icon_spacing);
		}
		
		// Span.
		public function get span():Number{
			return (_icon_min - 16) * (240 - 60) / (96 - 16) + 60;
		}
		
		// Ratio.
		public function get ratio():Number{
			return Math.PI / 2 / span;
		}
		
		// Trend.
		public function get trend():Number{
			return _trend;
		}
		
		public function set trend(value:Number):void{
			_trend = value;
		}
		/*
		public function set itemWidth(value:Number):void{
			if(value<0||value==_itemWidth){
				return;
			}
			_itemWidth=value;
			invalidate();
		}
		
		public function get itemWidth():Number{
			return _itemWidth;
		}
		
		public function set itemHeight(value:Number){
			if(value<0||value==_itemHeight){
				return;
			}
			_itemHeight=value;
			invalidate();
		}
		
		public function get itemHeight():Number{
			return _itemHeight;
		}
		
		public function set offsetX(value:Number):void{
			if(value<0||value==_offsetX){
				return;
			}
			_offsetX=value;
			invalidate();
		}
		
		public function get offsetX():Number{
			return _offsetX;
		}
		
		public function set offsetY(value:Number){
			if(value<0||value==_offsetY){
				return;
			}
			_offsetY=value;
			invalidate();
		}
		
		public function get offsetY():Number{
			return _offsetY;
		}
		*/
	}
}