package colorsprite.debug{
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	public class Extractor{
		
		public static function getInfo(o:*):String{
			if(o==null){
				return "null";
			}
			var info:String="################\t"+o.toString()+"\n";
			info+="#\t[Class]\t"+getQualifiedClassName(o)+"\n";
			info+="#\t[Super Class]\t"+getQualifiedSuperclassName(o)+"\n";
			info+="#\t[Type]\t"+(typeof o)+"\n################\n";
			return info;
		}
	}
}