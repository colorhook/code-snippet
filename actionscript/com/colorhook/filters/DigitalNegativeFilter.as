package colorsprite.filters{
	import flash.filters.BitmapFilter;
	import colorsprite.filters.SpecificFilter;
	import flash.filters.ColorMatrixFilter;
	public class DigitalNegativeFilter extends SpecificFilter {
		public function DigitalNegativeFilter(){
			this.filter=new ColorMatrixFilter([-1,0,0,0,255,
																		0,-1,0,0,255,
																		0,0,-1,0,255,
																		0,0,0,1,0])  as  BitmapFilter;
		}
	}
}