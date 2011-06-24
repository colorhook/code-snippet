package com.colorhook.utils{
	
	
	/**
	* @description AccessUtils is a static class, you cann't create an instance of it.
	* It used for set a class constructor or a method is abstract.
	*
	* @author colorhook
	* @copyright http://www.colorhook.com
	*/

	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	
	
	public class AccessUtil{
		
		
		public static const ERROR_MSG:String="AccessUtil Error: You cannot call an abstract method.";
		
		
		/**
		* @description set a class constructor or a method is abstract.
		* @param target the target to set.
		* @param ns the qualified namespace of target.
		* @return void.
		*/
		public static function setAbstract(target:*,ns:String):void {
			if (getQualifiedClassName(target)==ns) {
				throw new Error(ERROR_MSG);
			}
		}
		
		/**
		* check if the target is final.
		* @return Boolean
		*/
		public static function isFinal(target:*):Boolean {
			return describeType(target).type.@isFinal.toString()=="true";
		}
		
		
		/**
		* check if the target is final.
		* @return Boolean
		*/
		public static function isStatic(target:*):Boolean {
			return describeType(target).type.@isStatic.toString()=="true";
		}
		
		
		/**
		* check if the target is dynamic.
		* @return Boolean
		*/
		public static function isDynamic(target:*):Boolean {
			return describeType(target).type.@isDynamic.toString()=="true";
		}
		
		
		/**
		* check if the target extends a special class.
		* @return Boolean
		*/
		public static function isExtends(target:*,className:String):Boolean {
			var implXMLList:XMLList=describeType(target).extendsClass.@type;
			for (var i:int=0; i<implXMLList.length(); i++) {
				if (implXMLList[i].toString()==className) {
					return true;
				}
			}
			return false;
		}
		
		
		/**
		* check if the target implements a special interface.
		* @return Boolean
		*/
		public static function isImplements(target:*,interfaceName:String):Boolean {
			var implXMLList:XMLList=describeType(target).implementsInterface.@type;
			for (var i:int=0; i<implXMLList.length(); i++) {
				if (implXMLList[i].toString()==interfaceName) {
					return true;
				}
			}
			return false;
		}
	}
}