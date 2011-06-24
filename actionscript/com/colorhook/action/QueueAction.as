package com.colorhook.action{

	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 *
	 * 队列动作
	 * 动作列表依次执行，一个动作执行完毕之前后续动作将会等待
	 * 执行完毕发出Event.COMPLETE事件
	 * 
	 */
	
	[Event(name="complete",type="flash.events.Event")]
	
	public final class QueueAction extends EventDispatcher implements IAction{
		
		private var _map:Array;
		private var _index:uint;
		
		public function QueueAction() {
			_map=new Array;
			_index=0;
		}
		
		public function addAction(item:IAction):void {
			_map.push(item);
		}
		
		public function addActionAt(item:IAction,index:uint) {
			if (index >= _map.length) {
				_map.push(item);
			} else {
				_map.splice(index,0,item);
			}
		}
		
		public function removeAction(item:IAction):void {
			var index=_map.indexOf(item);
			if (index != -1) {
				_map.splice(index,1);
			}
		}
		
		public function removeActionAt(i):void{
			if(i>=0&&i<_map.length){
				_map.splice(i,1);
			}
		}
		
		public function removeAll():void{
			_map=new Array;
			_index=0;
		}
		
		/**
		*执行此方法开始执行动作
		*/
		public function execute():void {
			if (_map.length == 0) {
				onActionOver();
			} else {
				executeItemAt(0);
			}
		}
		
		private function executeItemAt(i:uint):void {
			_index=i;
			var item=_map[i]  as  IAction;
			item.addEventListener(Event.COMPLETE,itemCompleteHandler,false,0,true);
			item.execute();
			
		}
		
		private function itemCompleteHandler(e:Event):void {
			var item=e.target  as  IAction;
			item.removeEventListener(Event.COMPLETE,itemCompleteHandler);
			executeNextItem();
		}
		
		private function executeNextItem():void {
			var index:uint=_index + 1;
			if (index >= _map.length) {
				onActionOver();
			} else {
				executeItemAt(index);
			}
		}
		
		private function onActionOver():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}