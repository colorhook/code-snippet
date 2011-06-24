package colorsprite.filters{
	
	import flash.filters.BitmapFilter
	import colorsprite.filters.SpecificFilter;
	import flash.filters.ColorMatrixFilter;
	
	public class GrayscaleFilter extends SpecificFilter {
		
		
		public function GrayscaleFilter(){
			
			filter=new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,
										 0.3086,0.6094,0.082,0,0,
										 0.3086,0.6094,0.082,0,0,
										 0,0,0,1,0]) as BitmapFilter;
		}
		
		
	}
}