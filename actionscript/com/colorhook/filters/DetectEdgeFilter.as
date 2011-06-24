package colorsprite.filters{
	import flash.filters.BitmapFilter;
	import colorsprite.filters.SpecificFilter;
	import flash.filters.ConvolutionFilter;
	public class DetectEdgeFilter extends SpecificFilter{
		public function DetectEdgeFilter(){
			this.filter= new ConvolutionFilter(3,3,[0,1,0,1,-1,1,0,1,0]) as BitmapFilter;
		}
		
	}
}