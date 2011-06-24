package com.colorhook.tools{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 *
	 */
	 
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public dynamic class Watcher extends Proxy{
		
		private var _target:*;
		private var _list:Dictionary;
		
		public function Watcher(target:*){
			_target=target;
			_list=new Dictionary(true);
		}
		
		public function watch(prop:*,callback:Function):void{
			if(callback!=null)
			_list[prop]=callback;
		}
		
		public function unwatch(prop):void{
			delete _list[prop];
		}
		
		public function clear():void{
			_list=new Dictionary(true);
		}
		

		override flash_proxy function callProperty(methodName:*,...rest):*{
			return _target[methodName].apply(_target,rest);
		}
		
		flash_proxy override function deleteProperty(name:*):Boolean {
			return delete _target[name];
		}
		
		override flash_proxy function getDescendants(name:*):*{
			return _target.descendants(name);
		}
		override flash_proxy function getProperty(name:*):*{
			return _target[name];
		}
		override flash_proxy function setProperty(name:*,value:*):void{
			var oldValue:*=_target[name];
			_target[name]=value;
			if(_list[name]){
				try{
				_list[name](oldValue)
				}catch(e:Error){_list[name]()}
			}
		}
		override flash_proxy  function hasProperty(name:*):Boolean {
			return _target.hasOwnProperty(name);
		}
		/**
		 * @nextNameIndex
		 * @nextName
		 * @nextValue
		 */
		protected var _item:Array; 
    	override flash_proxy function nextNameIndex (index:int):int {
			 if (index == 0) {
				 _item = new Array();
				 for (var x:* in _target) {
					_item.push(x);
				 }
			 }
			 if (index < _item.length) {
				 return index + 1;
			 } else {
				 return 0;
			 }
		 }
		 override flash_proxy function nextName(index:int):String {
			 return _item[index - 1];
		 }
		override flash_proxy  function nextValue(index:int):* {
				return _target[_item[index - 1]];
		}
		
		//////////////////////////////////////////////////////////////////////////////////
	}
}