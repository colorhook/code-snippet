package com.kouobei.luckygauge.service{
	import com.kouobei.luckygauge.model.ModelLocator;
	import com.kouobei.luckygauge.utils.XMLUtil;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.setTimeout;
	
	/**
	 * ServiceDelegate is a service delegate used to communicate between Client end and Service end.
	 * @author 正邪
	 * @see IServiceDelegate
	 */
	
	public class ServiceDelegate extends EventDispatcher implements IServiceDelegate {
		
		//HTTP Request URL
		public static var ENDPOINT:String = 'http://www.koubei.com/coin/award.html';
		public static var ENDPOINT_FIRST:String = 'http://www.koubei.com/coin/awardinit.html';
		
		protected var loader:URLLoader;
		protected var model:ModelLocator;
		private var initialized:Boolean = false;
		
		public function ServiceDelegate() {
			loader = new URLLoader();
			model = ModelLocator.getInstance();
		}
		
		/**
		 * @see IServiceDelegate
		 */
		public function shakeHand():void {
			addLoaderListener();
			if (ENDPOINT == null || ENDPOINT == '') {
				throw new Error('The ENDPOINT of ServiceDelegate is not valid');
			}
			var params:URLVariables = new URLVariables;
			params.initFlag = 1;
			params.kbToken = model.kbToken;
			var request:URLRequest = new URLRequest(ENDPOINT);
			request.data = params;
			request.method = URLRequestMethod.POST;
			loader.load(request);
		}
		/**
		 * @see IServiceDelegate
		 */
		public function doService():void {
			addLoaderListener();
			if (ENDPOINT == null || ENDPOINT == '') {
				throw new Error('The ENDPOINT of ServiceDelegate is not valid');
			}
			var params:URLVariables = new URLVariables;
			params.kbToken = model.kbToken;
			var request:URLRequest = new URLRequest(ENDPOINT);
			request.data = params;
			request.method = URLRequestMethod.POST;
			loader.load(request);
			
		}

		private function addLoaderListener():void {
			if (!loader.hasEventListener(Event.COMPLETE)) {
				loader.addEventListener(Event.COMPLETE, onLoaderComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
		}

		private function removeLoaderListener():void {
			if (loader.hasEventListener(Event.COMPLETE)) {
				loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			onError(null);
		}
		
		private function onError(e:*):void {
			removeLoaderListener();
			onServiceFault(e);
		}
		
		private function onLoaderComplete(e:Event):void {
			removeLoaderListener();
			onServiceResult(loader.data);
		}
		
		private function updatePrizeData(xml:XML):void {
			var prizeData:String = XMLUtil.getNode(xml, 'available');
			if (prizeData == null) {
				return;
			}
			model.prizeData = prizeData.split(":");
			model.dispatchEvent(new Event(ModelLocator.PRIZE_DATA_CHANGED));
		}
		
		private function parseShakeHand(response:*):void {
			var xml:XML;
			try {
				xml = new XML(response);
			}catch (error:Error) {
				model.dispatchEvent(new Event(ModelLocator.INITIALIZED));
				onServiceFault();
			}
			model.code = XMLUtil.getNode(xml, 'code');
			if (model.code != '200' && model.code != '300') {
				model.hasSignup = false;
			}else {
				model.hasSignup = true;
				model.username = XMLUtil.getNode(xml, 'username');
				model.tomorrowcount = int(XMLUtil.getNode(xml, 'tomorrowcount'));
				model.avaiableCount = int(XMLUtil.getNode(xml, 'count'));
			}
			updatePrizeData(xml);
			model.dispatchEvent(new Event(ModelLocator.INITIALIZED));
			
		}
		
		
		private function parseDoService(response:*):void {
			var xml:XML;
			try {
				xml = new XML(response);
			}catch (error:Error) {
				onServiceFault();
				return;
			}
			model.code = XMLUtil.getNode(xml, 'code');
			if (model.code == '200') {
				if(XMLUtil.hasNode(xml, 'prize')){
					model.prize = XMLUtil.getNode(xml, 'prize');
					model.deliveryid = XMLUtil.getNode(xml, 'deliveryid');
					model.avaiableCount = int(XMLUtil.getNode(xml, 'count'));
				}else {
					model.prize = null;
					onServiceFault();
					return;
				}
			}else if (model.code == '300') {
				model.prize = null;
				model.avaiableCount = 0;
			}else {
				onServiceFault();
			}
			updatePrizeData(xml);
		}
		protected function onServiceResult(response:*):void {
			model.response = response;
			if (initialized == false) {
				parseShakeHand(response);
				initialized = true;
				return;
			}
			parseDoService(response);
			model.dispatchEvent(new Event(ModelLocator.SERVICE_RESULT));
		}
		
		protected function onServiceFault(response:*= null):void {
			model.prize = '9';
			model.dispatchEvent(new Event(ModelLocator.SERVICE_FAULT));
		}
		
	}

}