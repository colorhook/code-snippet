package com.kouobei.luckygauge.view {
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author 正邪
	 */
	public interface IGaugeView {
		
		/**
		 * get the gauge pointer, application will rotate this object.
		 * @return DisplayObject
		 */
		function get pointer():*;
		/**
		 * get the run button, 
		 * the game will start playing after the run button clicked.
		 * @return InteractiveObject
		 */
		function get runButton():*;
		
		/**
		 * get runEnabled
		 * Indicate if the runButton clickable.
		 * @return Boolean
		 */
		function get runEnabled():Boolean;
		
		/**
		 * set runEnabled
		 * If the runEnable is true, then runButton can capture the mouse event.
		 * @return void
		 */
		function set runEnabled(value:Boolean):void;
	}
	
}