package com.colorhook.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;

	public class FPS extends Sprite {
		private var currentY:int;
		private var diagramTimer:int;
		private var tfTimer:int;
		private var downloadedBytes:uint = 0;
		private var socketOutBytes:uint = 0;
		private var socketOutLast:uint = 0;
		private var socketInBytes:uint = 0;
		private var mem:TextField;
		private var skn:TextField;
		private var diagram:BitmapData;
		private var socketOut:TextField;
		private var skins:int = -1;
		private var fps:TextField;
		private var socketInLast:uint = 0;
		private var tfDelay:int = 0;
		private var socketIn:TextField;
		private var dwl:TextField;
		private var skinsChanged:int = 0;
		
		private static  const maxMemory:uint = 4.1943e+007;
		private static  const diagramWidth:uint = 60;
		private static  const tfDelayMax:int = 10;
		private static  var instance:FPS;
		private static  const maxSocket:uint = 4200;
		private static  const diagramHeight:uint = 40;

		public function FPS(doc:DisplayObjectContainer) {
			var bitmap:Bitmap;
			fps = new TextField();
			mem = new TextField();
			skn = new TextField();
			dwl = new TextField();
			socketIn = new TextField();
			socketOut = new TextField();
			if (instance == null) {
				mouseEnabled = false;
				mouseChildren = false;
				doc.addChild(this);
				fps.defaultTextFormat = new TextFormat("Tahoma", 10, 13421772);
				fps.autoSize = TextFieldAutoSize.LEFT;
				fps.text = "FPS: " + Number(stage.frameRate).toFixed(2);
				fps.selectable = false;
				fps.x = -diagramWidth - 2;
				addChild(fps);
				mem.defaultTextFormat = new TextFormat("Tahoma", 10, 13421568);
				mem.autoSize = TextFieldAutoSize.LEFT;
				mem.text = "MEM: " + bytesToString(System.totalMemory);
				mem.selectable = false;
				mem.x = -diagramWidth - 2;
				mem.y = 10;
				addChild(mem);
				currentY = 20;
				skn.defaultTextFormat = new TextFormat("Tahoma", 10, 16737792);
				skn.autoSize = TextFieldAutoSize.LEFT;
				skn.text = "MEM: " + bytesToString(System.totalMemory);
				skn.selectable = false;
				skn.x = -diagramWidth - 2;
				dwl.defaultTextFormat = new TextFormat("Tahoma", 10, 13369548);
				dwl.autoSize = TextFieldAutoSize.LEFT;
				dwl.selectable = false;
				dwl.x = -diagramWidth - 2;
				socketIn.defaultTextFormat = new TextFormat("Tahoma", 10, 65280);
				socketIn.autoSize = TextFieldAutoSize.LEFT;
				socketIn.selectable = false;
				socketIn.x = -diagramWidth - 2;
				socketOut.defaultTextFormat = new TextFormat("Tahoma", 10, 26367);
				socketOut.autoSize = TextFieldAutoSize.LEFT;
				socketOut.selectable = false;
				socketOut.x = -diagramWidth - 2;
				diagram = new BitmapData(diagramWidth, diagramHeight, true, 553648127);
				bitmap = new Bitmap(diagram);
				bitmap.y = currentY + 4;
				bitmap.x = -diagramWidth;
				addChildAt(bitmap, 0);
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.addEventListener(Event.RESIZE, onResize);
				onResize();
				diagramTimer = getTimer();
				tfTimer = getTimer();
			} else {
				throw new Error("FPS is a Singleton. Use FPS.init to create FPS instance");
			}
			return;
		}

		private function bytesToString(num:uint):String {
			var result:String;
			if (num < 1024) {
				result = String(num) + "b";
			} else if (num < 10240) {
				result = Number(num / 1024).toFixed(2) + "kb";
			} else if (num < 102400) {
				result = Number(num / 1024).toFixed(1) + "kb";
			} else if (num < 1048576) {
				result = Math.round(num / 1024) + "kb";
			} else if (num < 10485760) {
				result = Number(num / 1048576).toFixed(2) + "mb";
			} else if (num < 104857600) {
				result = Number(num / 1048576).toFixed(1) + "mb";
			} else {
				result = Math.round(num / 1048576) + "mb";
			}
			return result;
		}

		private function onEnterFrame(e:Event):void {
			tfDelay++;
			if (tfDelay >= tfDelayMax) {
				tfDelay = 0;
				fps.text = "FPS: " + Number(1000 * tfDelayMax / (getTimer() - tfTimer)).toFixed(2);
				tfTimer = getTimer();
			}
			var dTime:* = 1000 / (getTimer() - diagramTimer);
			var fixTime:* = dTime > stage.frameRate ? (1) : (dTime / stage.frameRate);
			diagramTimer = getTimer();
			diagram.scroll(1, 0);
			diagram.fillRect(new Rectangle(0, 0, 1, diagram.height), 553648127);
			diagram.setPixel32(0, diagramHeight * (1 - fixTime), 4291611852);
			mem.text = "MEM: " + bytesToString(System.totalMemory);
			var _loc_4:* = skins == 0 ? (0) : (skinsChanged / skins);
			diagram.setPixel32(0, diagramHeight * (1 - _loc_4), 4294927872);
			var _loc_5:* = System.totalMemory / maxMemory;
			diagram.setPixel32(0, diagramHeight * (1 - _loc_5), 4291611648);
			var _loc_6:* = (socketInBytes - socketInLast) / maxSocket;
			socketInLast = socketInBytes;
			diagram.setPixel32(0, diagramHeight * (1 - _loc_6), 4278255360);
			var _loc_7:* = (socketOutBytes - socketOutLast) / maxSocket;
			socketOutLast = socketOutBytes;
			diagram.setPixel32(0, diagramHeight * (1 - _loc_7), 4278216447);
			return;
		}

		private function onResize(e:Event = null):void {
			var point:* = parent.globalToLocal(new Point(stage.stageWidth - 2, -3));
			x = point.x;
			y = point.y;
			return;
		}

		public static function addDownloadBytes(num:uint):void {
			if (instance.downloadedBytes == 0) {
				instance.dwl.y = instance.currentY;
				instance.currentY = instance.currentY + 10;
				instance.addChild(instance.dwl);
				instance.getChildAt(0).y = instance.currentY + 4;
			}
			instance.downloadedBytes = instance.downloadedBytes + num;
			instance.dwl.text = "DWL: " + instance.bytesToString(instance.downloadedBytes);
			return;
		}

		public static function init(doc:DisplayObjectContainer):void {
			instance = new FPS(doc);
			return;
		}

		public static function addSocketInBytes(num:uint):void {
			if (instance.socketInBytes == 0) {
				instance.socketIn.y = instance.currentY;
				instance.currentY = instance.currentY + 10;
				instance.addChild(instance.socketIn);
				instance.getChildAt(0).y = instance.currentY + 4;
			}
			instance.socketInBytes = instance.socketInBytes + num;
			instance.socketIn.text = "IN: " + instance.bytesToString(instance.socketInBytes);
			return;
		}

		public static function addSocketOutBytes(num:uint):void {
			if (instance.socketOutBytes == 0) {
				instance.socketOut.y = instance.currentY;
				instance.currentY = instance.currentY + 10;
				instance.addChild(instance.socketOut);
				instance.getChildAt(0).y = instance.currentY + 4;
			}
			instance.socketOutBytes = instance.socketOutBytes + num;
			instance.socketOut.text = "OUT: " + instance.bytesToString(instance.socketOutBytes);
			return;
		}

		public static function addSkins(p1:uint, p2:uint):void {
			if (instance.skins < 0) {
				instance.skn.y = instance.currentY;
				instance.currentY = instance.currentY + 10;
				instance.addChild(instance.skn);
				instance.getChildAt(0).y = instance.currentY + 4;
			}
			instance.skins = p1;
			instance.skinsChanged = p2;
			instance.skn.text = "SKN: " + (p2 > 0 ? (p1.toString() + "-" + p2.toString()) : (p1.toString()));
			return;
		}

	}
}