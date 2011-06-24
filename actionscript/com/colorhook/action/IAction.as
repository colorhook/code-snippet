package colorsprite.action{
	
	import flash.events.IEventDispatcher
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 *
	 * IAction 表示一个动作
	 * @see QueueAction
	 * @see ParallelAction
	 */
	 
	public interface IAction extends IEventDispatcher{
		
		function execute():void
		
	}
}
