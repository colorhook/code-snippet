package colorsprite.filters{
	import flash.filters.BitmapFilter;
	import colorsprite.filters.SpecificFilter;
	import flash.filters.ConvolutionFilter
	public class EmbossFilter extends SpecificFilter{
		public function EmbossFilter(){
			this.filter=  new ConvolutionFilter(3,3,[-2,-1,0,-1,1,1,0,1,2]) as BitmapFilter;
		}
	}
}