package colorsprite.filters{
	
	import flash.filters.BitmapFilter;
	import colorsprite.filters.SpecificFilter;
	import flash.filters.ConvolutionFilter;
	
	public class SharpenFilter extends SpecificFilter{
		
		public function SharpenFilter(){
			this.filter=new ConvolutionFilter(3,3,[0,-1,0,-1,5,-1,0,-1,0]) as BitmapFilter;
		}
	}
}