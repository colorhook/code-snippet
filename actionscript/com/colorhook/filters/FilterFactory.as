package colorsprite.filters{
	import flash.filters.BitmapFilter;
	public class FilterFactory {
		public static function getFilter(filterClass:SpecificFilter):BitmapFilter {
			return filterClass.filter;
		}
		public static function getFilterArray(arr:Array):Array{
			var result:Array=new Array();
			for each(var item in arr){
				if(item is SpecificFilter){
					result.push(item.filter);
				}
			}
			return result;
		}
	}
}