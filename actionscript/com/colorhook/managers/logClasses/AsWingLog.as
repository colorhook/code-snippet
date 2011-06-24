package com.colorhook.managers.logClasses
{

	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import org.aswing.ASFont;
	import org.aswing.AsWingManager
	import org.aswing.BorderLayout;
	import org.aswing.JFrame;
	import org.aswing.JTextArea;

	/**
	 * @version	1.0
	 * @author colorhook
	 */

	public class AsWingLog extends AbstractLog implements ILog
	{
		
		
			protected var frame:JFrame;
			protected var textField:JTextArea;
			
			private var _frameTitle:String="AsWing Log";
			private var _frameWidth:int=320;
			private var _frameHeight:int=200;
			
			public function AsWingLog(root:DisplayObjectContainer, workWidthFlex:Boolean = false ) {
				AsWingManager.initAsStandard(root, true, workWidthFlex);
				init();
			}
			
			private function init():void {
				setupUI();
			}
			
			private function setupUI():void {
				frame = new JFrame(AsWingManager.getRoot(), _frameTitle);
				textField = new JTextArea();
				textField.setWordWrap(true);
				textField.setFont(new ASFont("Verdana", 12));
				textField.setEditable(false);
				var newContextMenu:ContextMenu = new ContextMenu;
				var clearMenItem:ContextMenuItem = new ContextMenuItem("clear");
				clearMenItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, clearTextField);
				newContextMenu.customItems.push(clearMenItem);
				textField.contextMenu = newContextMenu;
				frame.getContentPane().setLayout(new BorderLayout(5));
				frame.getContentPane().append(textField);	
				frame.setSizeWH(_frameWidth, _frameHeight);
				frame.setClosable(false);
				frame.addEventListener("stateChanged", onFrameStateChanged,false,0,true);
				frame.show();
			}
			
			private function clearTextField(e:ContextMenuEvent = null):void {
				textField.getTextField().htmlText = "";
			}
			private function onFrameStateChanged(e:Event):void {
				if (frame.getState() == 2) {
					frame.alpha = 0.5;
				}else {
					frame.alpha = 1;
				}
			}
			
			public override function log(msg:String, object:Object = null, arguments:Array = null):void {
				super.log(msg, object, arguments);
				textField.getTextField().htmlText += "<font color='#000000'>"+currentLog + "</font><br/>";
			}
			
			public override function info(msg:String, object:Object = null, arguments:Array = null):void {
				super.info(msg,object,arguments);
				textField.getTextField().htmlText += "<font color='#0066CC'>"+currentLog + "</font><br/>";
				
			}
			
			public override function debug(msg:String, object:Object = null, arguments:Array = null):void {
				super.debug(msg,object,arguments);
				textField.getTextField().htmlText += "<font color='#99CC00'>"+currentLog + "</font><br/>";
			}
		
			public override function warning(msg:String, object:Object = null, arguments:Array = null):void {
				super.warning(msg,object,arguments);
				textField.getTextField().htmlText += "<font color='#AA6600'>"+currentLog + "</font><br/>";
			}
			
			public override function error(msg:String, object:Object = null, arguments:Array = null):void {
				super.error(msg,object,arguments);
				textField.getTextField().htmlText += "<font color='#993333'>" + currentLog + "</font><br/>";
			}
		
			public override function fatal(msg:String, object:Object = null, arguments:Array = null):void {
				super.fatal(msg,object,arguments);
				textField.getTextField().htmlText += "<font color='#FF0000'>"+currentLog + "</font><br/>";
			}
			
		}
		
	
}