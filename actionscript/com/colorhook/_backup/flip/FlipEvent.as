package colorsprite.flip{
	
	import flash.events.Event;
	
	/**
	*基于xml文件的翻页as3类
	*翻页的动作事件
	*@Modify-Date 2008-8-30
	* @author colorsprite
	*/
	
	public class FlipEvent extends Event {
		
		public static const  PAGE_LOAD_COMPLETE:String="pageLoadComplete";
		public static const  PAGE_PROGRESS:String="pageProgress";
		public static const  IO_ERROR:String="ioError";
		public static const FLIP_DRAG_START:String="flipDragStart";
		public static const FLIP_DRAG_STOP:String="flipDragStop";
		public static const FLIP_START:String="flipStart";
		public static const FLIP_COMPLETE:String="flipComplete";
		public static const NEXT_PAGE:String="nextPage";
		public static const PREV_PAGE:String="prevPage";
		public static const HOME_PAGE:String="homePage";
		public static const END_PAGE:String="endPage";

		public function FlipEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false) {
			super(type,bubbles,cancelable);
		}
	}
}