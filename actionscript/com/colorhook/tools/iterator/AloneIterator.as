package com.colorhook.tools.iterator{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 */
	
	public class AloneIterator{
		
		private var _length:int;
		private var _index:int;
		private var _mode:String;

		public function AloneIterator(len:int,mode:String="all") {
			if (len <= 0) {
				throw new Error("the length should bigger then ZORE!");
			} else {
				_length=len;
				_mode=mode;
				_index=0;
			}
		}
		
		public function next():void {
			switch(_mode){
				case "single":
				break;
				case "all":
				_index=(_index>=_length-1)?_length-1:_index+1;
				break;
				case "allCycle":
				_index=(_index>=_length-1)?0:_index+1;
				break;
				case "random":
				_index=getRandom();
				break;
				default:
				break;
			}
		}
		
		public function prev():void{
			switch(_mode){
				case "single":
				break;
				case "all":
				_index=(_index<=0)?0:_index-1;
				break;
				case "allCycle":
				_index=(_index<=0)?_length-1:_index-1;
				break;
				case "random":
				_index=getRandom();
				break;
				default:
				break;
			}
		}
		
		private function getRandom():int{
			return Math.floor(Math.random()*_length);
		}
		
		public function get index():int{
			return _index;
		}
		
		public function get length():int{
			return _length;
		}
		public function set length(value:int):void{
			_length=value;
			_index=0;
		}
		public function get mode():String{
			return _mode;
		}
		
		public function set mode(value:String):void{
			_mode=value;
		}
	}
}