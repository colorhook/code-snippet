package com.kouobei.luckygauge.service {
	
	import com.kouobei.luckygauge.model.ModelLocator;
	/**
	 * If the user is not a signup user but a guest, then response a random prize.
	 * @author 正邪
	 */
	public class GuestServiceDelegate implements IServiceDelegate{
		
		protected var model:ModelLocator;
		
		public function GuestServiceDelegate() {
			model = ModelLocator.getInstance();
		}
		
		public function doService():void {
			model.response = 'guest';
			model.setRandomPrize();
			model.dispatchEvent(new Event(ModelLocator.SERVICE_RESULT));
		}
	}

}