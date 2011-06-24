package com.colorhook.managers.toolTipClasses{

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;


	/**
	 *@version 2.0
	 *@author colorhook
	 * @description a pure ToolTip to meet the fl CS3 environment.
	 */

	public class ToolTip extends Sprite implements IToolTip {

		public static  var MAX_WIDTH:Number=300;
		
		public var callLaterInvoker:NextFrameCallLater;
		protected var textField:TextField;
		protected var background:Sprite;
		protected var _textFormat:TextFormat;

		private var _fillColor:uint;
		private var _color:uint;
		private var _fillAlpha:Number;
		private var _conerRadius:Number;
		private var _measuredWidth:Number;
		private var _measuredHeight:Number;

		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		private var _paddingLeft:Number;
		private var _paddingRight:Number;



		public function ToolTip():void {
			init();
			createChildren();
		}
		private function init():void {
			_color=0x000000;
			_fillColor=0xFFFFCC;
			_fillAlpha=1;
			_conerRadius=8;
			_measuredWidth=0;
			_measuredHeight=0;
			_paddingLeft=_paddingRight=5;
			_paddingBottom=_paddingTop=2;
			_textFormat=new TextFormat();
			_textFormat.font="Verdana";
			callLaterInvoker=new NextFrameCallLater(this);
			alpha=0.92;
		}
		/**
		 *add a background and a textField.
		 */
		protected function createChildren():void {
			background=new Sprite;
			updateDisplayList();
			addChild(background);
			background.filters=[new DropShadowFilter(0.5)];
			textField=new TextField;
			textField.textColor=_color;
			textField.defaultTextFormat=_textFormat;
			textField.selectable=false;
			setToolTip();
			addChild(textField);
		}
		/**
		 *Redraw the background
		 */
		public function updateDisplayList():void {
			background.graphics.clear();
			background.graphics.beginFill(_fillColor,_fillAlpha);
			background.graphics.drawRoundRect(0,0,_measuredWidth,_measuredHeight,_conerRadius);
			background.graphics.endFill();
			this.dispatchEvent(new ToolTipEvent(ToolTipEvent.TOOLTIP_REDRAW));
		}
		/**
		 *Reset the width and height of the textField .
		 */
		private function setToolTip():void {
			textField.x=_paddingLeft;
			textField.y=_paddingTop;
			textField.width=_measuredWidth-_paddingLeft-_paddingRight;
			_measuredHeight=textField.textHeight+_paddingTop+_paddingBottom+textField.getLineMetrics(0).leading+6;
			textField.height=_measuredHeight-_paddingTop+_paddingBottom;
		}
		
		protected function callLater(f:Function){
			callLaterInvoker.call(f);
		}
		/**
		 *invoked while any property of the background changed.
		 */
		protected function invalidateDisplayList():void {
			callLater(updateDisplayList);
		}
		/**
		 *invoked while the property text changed;
		 */
		protected function invalidateProperties():void {
			callLater(measure);
		}
		/**
		 *Compute the size of the textField.
		 */
		public function measure():void {
			textField.wordWrap=false;
			textField.multiline=false;
			var textWidth:Number=textField.textWidth+_paddingLeft+_paddingRight+6;
			var textHeight:Number=textField.textHeight+_paddingTop+_paddingBottom+textField.getLineMetrics(0).leading+6;

			if (textWidth>MAX_WIDTH) {
				textField.wordWrap=true;
				_measuredWidth=MAX_WIDTH;
			} else {
				_measuredWidth=textWidth;
			}
			textField.width=_measuredWidth-_paddingLeft-_paddingRight;
			_measuredHeight=textField.textHeight+_paddingTop+_paddingBottom+textField.getLineMetrics(0).leading+6;
			setToolTip();
			updateDisplayList();
		};

		/**
		 *set the tool tip by text property.
		 */
		public function set text(value:String):void {
			textField.text=value;
			invalidateProperties();
		}
		/**
		 *get the text. 
		 */
		public function get text():String {
			return textField.text;
		}
		/**
		 *set the text format.
		 */
		public function set textFormat(format:TextFormat):void {
			format.indent=format.blockIndent=format.leftMargin=format.rightMargin=0;
			_textFormat=format;
			textField.defaultTextFormat=_textFormat;
			invalidateProperties();
		}
		/**
		 *get the text format.
		 */
		public function get textFormat():TextFormat {
			return _textFormat;
		}
		/**
		 *get the text padding left.
		 */
		public function get paddingLeft():Number {
			return _paddingLeft;
		}
		/**
		 *set the text padding left.
		 */
		public function set paddingLeft(value:Number):void {
			if (value<0) {
				return;
			}
			_paddingLeft=value;
			invalidateDisplayList();
		}
		/**
		 *get the text padding right.
		 */
		public function get paddingRight():Number {
			return _paddingRight;
		}
		/**
		 *set the text padding right.
		 */
		public function set paddingRight(value:Number):void {
			if (value<0) {
				return;
			}
			_paddingRight=value;
			invalidateDisplayList();
		}
		/**
		 *get the text padding bottom.
		 */
		public function get paddingBottom():Number {
			return _paddingBottom;
		}
		/**
		 *set the text padding bottom.
		 */
		public function set paddingBottom(value:Number):void {
			if (value<0) {
				return;
			}
			_paddingBottom=value;
			invalidateDisplayList();
		}
		/**
		 *get the text padding top.
		 */
		public function get paddingTop():Number {
			return _paddingTop;
		}
		/**
		 *set the text padding top.
		 */
		public function set paddingTop(value:Number):void {
			if (value<0) {
				return;
			}
			_paddingTop=value;
			invalidateDisplayList();
		}
		/**
		 *set the background alpha.
		 */
		public function get fillAlpha():Number {
			return _fillAlpha;
		}
		/**
		 *get the background alpha.
		 */
		public function set fillAlpha(value:Number):void {
			if (value>=0&&value<=1) {
				_fillAlpha=value;
				invalidateDisplayList();
			}
		}
		/**
		 *set the text color.
		 */
		public function get color():uint {
			return _color;
		}
		/**
		 *get the text color.
		 */
		public function set color(value:uint) {
			if (value==_color) {
				return;
			}
			_color=value;
			textField.textColor=_color;
			_textFormat.color=_color;
		}
		/**
		 *set the background color.
		 */
		public function get fillColor():uint {
			return _fillColor;
		}
		/**
		 *get the background color.
		 */
		public function set fillColor(value:uint) {
			_fillColor=value;
			invalidateDisplayList();
		}
	}
}

import flash.display.DisplayObject;
import flash.utils.Dictionary;
import flash.events.Event;

class NextFrameCallLater {

	private var _target:DisplayObject;
	private var methods:Dictionary;
	private var inCallLaterPhase:Boolean;

	public function NextFrameCallLater(target:DisplayObject) {
		this._target=target;
		inCallLaterPhase=false;
		methods=new Dictionary;
		super();
	}
	public function call(fun:Function):void {

		if (inCallLaterPhase||_target==null) {
			return;
		}
		methods[fun]=true;

		if (_target.stage != null) {
			_target.stage.addEventListener(Event.RENDER,callLaterDispatcher,false,0,true);
			_target.stage.invalidate();
		} else {
			_target.addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher,false,0,true);
		}
	}
	private function callLaterDispatcher(event:Event):void {
		if (event.type == Event.ADDED_TO_STAGE) {
			_target.removeEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher);
			_target.stage.addEventListener(Event.RENDER,callLaterDispatcher,false,0,true);
			_target.stage.invalidate();
			return;
		} else {
			event.target.removeEventListener(Event.RENDER,callLaterDispatcher);
			if (_target.stage == null) {
				_target.addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher,false,0,true);
				return;
			}
		}

		inCallLaterPhase = true;

		for (var method:Object in methods) {
			method();
			delete (methods[method]);
		}
		inCallLaterPhase = false;
	}
	public function get target():DisplayObject {
		return _target;
	}
}