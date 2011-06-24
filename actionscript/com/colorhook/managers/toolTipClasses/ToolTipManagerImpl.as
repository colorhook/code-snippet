package com.colorhook.managers.toolTipClasses{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.geom.Point;
	
	/**
	 * @author colorhook
	 * @version 1.0
	 */
	  
	public class ToolTipManagerImpl implements IToolTipManager {

		private var _stage:Stage;
		
		// the registered targets map
		private var _targetMap:Dictionary;
		
		// the tooltip object
		private var _toolTip:ToolTip;
		
		// indicate if the tooltip is showing
		private var _toolTipShowing:Boolean;
		
		//indicate if the tooltip is enabled or not.
		private var _enabled:Boolean=true;
		
		
		
		private var _showDelay:Number=500;
		//indicate the last time after the tooltip showed.
		private var _hideDelay:Number=6000;
		private var _scrubDelay:Number=100;
		private var _movable:Boolean=true;
		
		protected var _currentTarget:DisplayObject;
		
		
		private var scrubTimer:Timer;
		private var hideTimer:Timer;
		private var showTimer:Timer;
		
		private var _addStageListener:Boolean;
		
		
		protected static  var instance:ToolTipManagerImpl;

		public function ToolTipManagerImpl() {
			
			if (instance!=null) {
				throw new Error("ToolTipManagerImple is a singleton.");
			}
			initialize();
		}
		
		
		
		public static function getInstance():ToolTipManagerImpl {
			if (instance==null) {
				instance=new ToolTipManagerImpl()
			}
			return instance;
		}
		
		
		
		private function initialize():void {
			_targetMap=new Dictionary()
			_toolTip=new ToolTip;
			_addStageListener=false;
			_toolTip.addEventListener(Event.ADDED_TO_STAGE,onToolTipAdded,false,0,true)
			_toolTip.addEventListener(ToolTipEvent.TOOLTIP_REDRAW,onToolTipRedraw,false,0,true)
			_toolTipShowing=false;
			setupTimer();
		}
		
		/**
		 * when tooltip is added to a stage, initliaze the stage add add listeners.
		 */
		private function onToolTipAdded(e:Event):void{
			var stage:Stage=_toolTip.stage;
			_stage=stage;
			if(_addStageListener){
				return;
			}
			stage.addEventListener(Event.ADDED,onStageAddNewElement,false,0,true);
			_toolTip.addEventListener(Event.REMOVED_FROM_STAGE,onToolTipRemoved,false,0,true)
			_addStageListener=true;
		}
		
		private function onToolTipRemoved(e:Event):void{
			try{
				_stage.removeEventListener(Event.ADDED,onStageAddNewElement);
				_toolTip.removeEventListener(Event.REMOVED_FROM_STAGE,onStageAddNewElement);
				_addStageListener=false;
			}catch(error:Error){}
		}
		
		private function onStageAddNewElement(e:Event):void{
			var container:DisplayObjectContainer=_toolTip.parent;
			container.setChildIndex(_toolTip,container.numChildren-1);
		}
		
		private function setupTimer():void {
			if (showTimer==null) {
				showTimer = new Timer(_showDelay, 1);
				showTimer.addEventListener(TimerEvent.TIMER, showTimer_timerHandler,false,0,true);
			}
			if (hideTimer==null) {
				hideTimer = new Timer(_hideDelay, 1);
				hideTimer.addEventListener(TimerEvent.TIMER, hideTimer_timerHandler,false,0,true);

			}
			if (scrubTimer==null) {
				scrubTimer = new Timer(_scrubDelay, 1);
				scrubTimer.addEventListener(TimerEvent.TIMER, scrubTimer_timerHandler,false,0,true);
			}
		}
		
		private function resetTimer():void {
			showTimer.reset();
			hideTimer.reset();
			scrubTimer.reset();
		}
		
		
		public function get toolTip():ToolTip {
			return _toolTip;
		}
		
		public function set toolTip(value:ToolTip):void{
			if(value==null){
				return;
			}
			_toolTip.removeEventListener(Event.ADDED_TO_STAGE,onToolTipAdded)
			_toolTip.removeEventListener(ToolTipEvent.TOOLTIP_REDRAW,onToolTipRedraw)
			_toolTip=value;
			_toolTip.addEventListener(Event.ADDED_TO_STAGE,onToolTipAdded,false,0,true)
			_toolTip.addEventListener(ToolTipEvent.TOOLTIP_REDRAW,onToolTipRedraw,false,0,true)
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void {
			_enabled=value;
			if(!_enabled&&_toolTipShowing){
				resetTimer();
				hideToolTip();
			}
		}
		
		public function get hideDelay():Number {
			return _hideDelay;
		}
		public function set hideDelay(value:Number):void {
			if (value<50) {
				return;
			}
			_hideDelay=value;
		}
		public function get scrubDelay():Number {
			return _scrubDelay;
		}
		public function set scrubDelay(value:Number):void {
			if (value<50) {
				_scrubDelay=0;
				return;
			}
			_scrubDelay=value;
		}
		public function get showDelay():Number {
			return _showDelay;
		}
		public function set showDelay(value:Number):void {
			if (value<50) {
				return;
			}
			_showDelay=value;
		}
		
		
		public function get movable():Boolean{
			return _movable;
		}
		
		public function set movable(value:Boolean):void{
			if(_movable==value){
				return;
			}
			_movable=value;
			if(movable&&_toolTip.stage){
				_toolTip.stage.addEventListener(Event.ENTER_FRAME,onStageEnterFrame,false,0,true);
			}
				
		}
		
		/**
		 *	register the display object. Tooltip is a plain sting.
		 */
		public function setToolTip(target:DisplayObject,text:String):void {
			if(text==null||text==""){
				removeToolTip(target);
				return;
			}
			if (!containsTarget(target)) {
				target.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverTarget,false,0,true);
				target.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutTarget,false,0,true);
			}
			_targetMap[target]=text;
		}
		
		
		/**
		 *	unregister the display object.
		 */
		public function removeToolTip(target:DisplayObject):void {
			if (target!=null&&containsTarget(target)) {
				target.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverTarget);
				target.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutTarget);
				delete _targetMap[target];
			}
		}
		
		/**
		 *	return true if the display object is registered.
		 *	@return Boolean
		 */
		public function containsTarget(target:DisplayObject):Boolean {
			return _targetMap[target] != null;
		}
		
		/**
		 *	the focue display object correspond to the tooltip, return null if no tooltip exist currently.
		 *	@return DisplayObject
		 */
		public function get currentTarget():DisplayObject{
			return _currentTarget;
		}
		
		
		/**
		 *	the logic while mouse over
		 */
		private function onMouseOverTarget(e:MouseEvent):void {
			if(!_enabled||e.currentTarget==_currentTarget){
				return;
			}
			_currentTarget=e.currentTarget as DisplayObject;
			if(scrubTimer.running){
				scrubTimer.reset();
				showToolTip();
			}else{
				showTimer.start();
			}
		}
		
		/**
		 *	the logic while mouse out
		 */
		private function onMouseOutTarget(e:MouseEvent):void {
				if(!_enabled){
					return;
				}
				if(mouseIsOver(_toolTip)){
					if(!_toolTip.hasEventListener(Event.ENTER_FRAME))
					_toolTip.addEventListener(Event.ENTER_FRAME,checkToolTipState,false,0,true);
					return;
				}
				resetTimer();
				hideToolTip();
				scrubTimer.start();
		}
		
		private function checkToolTipState(e:Event):void{
			if(mouseIsOver(_currentTarget)||mouseIsOver(_toolTip)){
				return;
			}else{
				resetTimer();
				hideToolTip();
				scrubTimer.start();
			}
		}
		
		/**
		 *	Check if the object under the mouse.
		 */
		private function mouseIsOver(target:DisplayObject):Boolean{
    		if (!target || !target.stage)
    			return false;

    		if ((target.stage.mouseX == 0)	 && (target.stage.mouseY == 0))
    			return false;
    		
    		return target.hitTestPoint(target.stage.mouseX,
    							   	target.stage.mouseY, true);
   		 }
		
		
		private function showTimer_timerHandler(e:TimerEvent):void {
			resetTimer();
			showToolTip();
		}
		private function hideTimer_timerHandler(e:TimerEvent):void {
			resetTimer();
			hideToolTip();
		}
		
		private function scrubTimer_timerHandler(e:TimerEvent):void {
			scrubTimer.reset()
		}
		
		
		/**
		 *	Hide the tooltip immediately.
		 */
		protected function showToolTip():void{
			var stage:Stage=_currentTarget.stage
			if(stage){
				if(_hideDelay>0){
					hideTimer.start()
				}
				_toolTip.text=_targetMap[_currentTarget];
				_toolTip.visible=false;
				stage.addChildAt(_toolTip,stage.numChildren);
				try{
					stage.removeEventListener(Event.ENTER_FRAME,onStageEnterFrame)
				}catch(e:Error){
				}
				if(this.movable){
					stage.addEventListener(Event.ENTER_FRAME,onStageEnterFrame,false,0,true);
				}else{
					if(!_toolTip.visible)
					_toolTip.visible=true;
				}
				_toolTipShowing=true;
				
				_toolTip.dispatchEvent(new ToolTipEvent(ToolTipEvent.TOOLTIP_SHOW));
			}
		}
		private function onStageEnterFrame(e:Event):void{
			positionToolTipEnterFrame();
		}
		/**
		 *	Hide the tooltip immediately.
		 */
		protected function hideToolTip():void{
			_currentTarget=null;
			var stage:Stage=_toolTip.stage;
			if(_toolTip.hasEventListener(Event.ENTER_FRAME)){
				_toolTip.removeEventListener(Event.ENTER_FRAME,checkToolTipState);
			}
			if(stage){
				stage.removeChild(_toolTip);
				_toolTipShowing=false;
				_toolTip.dispatchEvent(new ToolTipEvent(ToolTipEvent.TOOLTIP_HIDE));
			}
		}
		
		protected function positionToolTipEnterFrame():void{
			var stage:Stage=_toolTip.stage;
			if(stage==null){
				return;
			}
			
			var px=stage.mouseX;
			var py=stage.mouseY;
			
			if(px>stage.stageWidth*0.5){
				px=stage.mouseX-_toolTip.width-15;
			}else{
				px=stage.mouseX+15;
			}
			
			if(py>stage.stageHeight*0.5){
				py=stage.mouseY-_toolTip.height-15;
			}else{
				py=stage.mouseY+20;
			}
			
			_toolTip.x=px;
			_toolTip.y=py;
			if(!_toolTip.visible)
			_toolTip.visible=true;
		}
		
		/**
		 *	position tooltip to a apppropriate coordinate.
		 */
		protected function positionToolTip():void{
			var stage:Stage=_toolTip.stage;
			
			if(stage==null){
				return;
			}
			
			
			var tPoint:Point=stage.globalToLocal(new Point(_currentTarget.x,_currentTarget.y))
			
			
			var toolX:Number;
			var toolY:Number;
			var toolXOut:Boolean=false;
			var toolYOut:Boolean=false;
			
			if(tPoint.y-_toolTip.height-5>2){
				toolY=tPoint.y-_toolTip.height-5;
			}else if(tPoint.y+_currentTarget.height+5<stage.stageHeight-2){
				toolY=tPoint.y+_currentTarget.height+10;
			}else{
				if(stage.mouseY-10-_toolTip.height<2){
					toolY=stage.mouseY-10-_toolTip.height;
				}else{
					toolY=stage.mouseY+20;
				}
				toolYOut=true;
			}

			if(tPoint.x+_currentTarget.width+_toolTip.width+5<stage.stageWidth-2){
				
				toolX=tPoint.x+_currentTarget.width+5;
			}else if(tPoint.x-5-_toolTip.width<2){
				
				if(stage.mouseX+10+_toolTip.width<stage.stageWidth-2){
					toolX=stage.mouseX+10
				}else{
					toolX=stage.mouseX-10-_toolTip.width;
					if(toolX<2){
						toolX=2;
					}
				}
				toolXOut=true;
			}else{
				
				toolX=tPoint.x-5-_toolTip.width;
			}
			
			if(!toolYOut&&!toolXOut){
				
				var dx:Number=Math.abs(toolX-stage.mouseX);
				var dy:Number=Math.abs(toolY-stage.mouseY);
				if(dx>=dy){
					if(stage.mouseX+10+_toolTip.width<stage.stageWidth-2){
						
						toolX=stage.mouseX+10
					}else{
						toolX=stage.mouseX-10-_toolTip.width;
						
						if(toolX<2){
							toolX=2;
						}
					}
				}else{
					if(stage.mouseY+20+_toolTip.height<stage.stageHeight-2){
						toolY=stage.mouseY+20;
					}else{
						toolY=stage.mouseY-10-_toolTip.height;
						if(toolY<2){
							toolY=2;
						}
					}
				}
			}
			
			_toolTip.x=toolX;
			_toolTip.y=toolY;
			
			
		}
		
		private  function onToolTipRedraw(e:ToolTipEvent):void{
			if(!movable){
				positionToolTip();
			}
		}
		
		
	}
}