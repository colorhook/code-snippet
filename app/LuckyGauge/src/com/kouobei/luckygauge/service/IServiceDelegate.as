package com.kouobei.luckygauge.service {
	
	/**
	 * IServiceDelegate is a service delegate used to communicate between Client end and Service end.
	 * This Game has only one Remote Produce Call to get the prize infomation.
	 * @author 正邪
	 */
	public interface IServiceDelegate {
		
		/**
		 * send a HTTP request to get the user infomation and etc.
		 */
		function shakeHand():void;
		/**
		 * send a HTTP request to get the prize infomation.
		 */
		function doService():void ;
	}
	
}