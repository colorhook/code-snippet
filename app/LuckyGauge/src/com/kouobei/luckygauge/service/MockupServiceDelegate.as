package com.kouobei.luckygauge.service {
	
	import com.kouobei.luckygauge.model.ModelLocator;
	import flash.events.Event;
	import flash.utils.setTimeout;
	/**
	 * MockupServiceDelegate is a mockup class used to test application.
	 * @author 正邪
	 * @see IServiceDelegate
	 */
	public class MockupServiceDelegate implements IServiceDelegate {
		
		protected var model:ModelLocator;
		
		private var duration:Number;
		
		public function MockupServiceDelegate(duration:Number = 100) {
			this.duration = duration;
			model = ModelLocator.getInstance();
		}
		
		/**
		 * @see IServiceDelegate
		 */
		public function shakeHand():void {
			setTimeout(this.onServiceInitResult, this.duration);
		}
		/**
		 * after serveral seconds, response a mockup response.
		 */
		public function doService():void {
			setTimeout(this.onServiceResult, this.duration);
		}
		protected function onServiceInitResult():void {
			model.code = '200';
			model.avaiableCount = 20;
			model.tomorrowcount = 30;
			model.username = 'aaaa';
			model.hasSignup = true;
			model.dispatchEvent(new Event(ModelLocator.INITIALIZED));
		}
		protected function onServiceResult():void {
			model.hasSignup = true;
			model.response = 'mockup:result';
			model.prize = Math.floor(Math.random()*10)+"";
			model.code = '200';
			model.avaiableCount = 20;
			//model.setRandomPrize();
			model.dispatchEvent(new Event(ModelLocator.SERVICE_RESULT));
		}
		
		protected function onServiceFault():void {
			model.response = 'mockup:fault';
			model.dispatchEvent(new Event(ModelLocator.SERVICE_FAULT));
		}
	}

}