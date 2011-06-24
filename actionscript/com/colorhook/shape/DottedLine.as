package com.colorhook.shape{
	
	import com.colorhook.shape.BaseShape;
	import com.colorhook.shape.DrawStyle;
	
	public class DottedLine extends BaseShape{
		
		private var _steps:Array;
		private var _length:Number;
		public function DottedLine(length:Number=100,steps:Array=null,drawStyle:DrawStyle=null):void{
			this._length=length;
			this._steps=steps?steps:[4,2];
			super(drawStyle);
		}
		
		protected override function draw():void{
			this.graphics.moveTo(0,0);
			var currentLen:Number=0;
			var iterator:int=0;
			var stepCount:int=_steps.length;
			while(currentLen<_length){
			   this.graphics.moveTo(currentLen,0);
			   if(currentLen+_steps[iterator]>_length){
					break;
			   }
			   currentLen+=_steps[iterator++];
			   if(iterator>=stepCount){
					iterator=0;
			   }
			   this.graphics.lineTo(currentLen,0);
			   currentLen+=_steps[iterator++];
			   if(iterator>=stepCount){
					iterator=0;
			   }
			}
		}
		
		public function get length():Number{
			return _length;
		}
		
		public function set length(value:Number):void{
			if(value>0){
				_length=value;
				styleChanged();
			}
		}
		
		public function get steps():Array{
			return _steps;
		}
		public function set steps(value:Array):void{
			if(!value||value.length==0){
			   return;
			}
			for(var i:int=0;i<value.length;i++){
			    var item=Number(value[i]);
			    if(!isNaN(item)){
				_steps.push(item);
			    }
			}
		}
	}
}
			