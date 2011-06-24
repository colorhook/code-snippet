package com.colorhook.lite3d.render{
	
	/**
	 * @author colorhook
	 * @version 1.0
	 * @copyright http://www.colorhook.com
	 * 
	 */
	 
	import flash.display.DisplayObject;
	
	import com.colorhook.lite3d.geom.Point3D;
	import com.colorhook.lite3d.scene.IScene3D;
	import com.colorhook.lite3d.camera.ICamera3D;
	import com.colorhook.lite3d.view.IView3D;
	
	public class RenderEngine implements IRenderEngine{
		
		public static var factor:Number=Math.PI/180;
		
		
		public function render(scene:IScene3D,camera:ICamera3D,view:IView3D):void{
			
			var pitchValue=camera.pitch*factor;
			var yawValue=camera.yaw*factor;
			var rollValue=camera.roll*factor;
			var rX=camera.rotationX*factor;
			var rY=camera.rotationY*factor;
			var rZ=camera.rotationZ*factor;

			var pitchCos:Number=Math.cos(pitchValue);
			var pitchSin:Number=Math.sin(pitchValue);
			var yawCos:Number=Math.cos(yawValue);
			var yawSin:Number=Math.sin(yawValue);
			var rollCos:Number=Math.cos(rollValue);
			var rollSin:Number=Math.sin(rollValue);

			var rxCos:Number=Math.cos(rX);
			var rxSin:Number=Math.sin(rX);
			var ryCos:Number=Math.cos(rY);
			var rySin:Number=Math.sin(rY);
			var rzCos:Number=Math.cos(rZ);
			var rzSin:Number=Math.sin(rZ);
			

			
			var cameraPos:Point3D=camera.position;
			var direction:Point3D=new Point3D(camera.pitch,camera.yaw,camera.roll)
			var sortArr:Array=[];
			var items:Array=view.getAllChildren();
			
			for(var i:int=0,len:int=items.length;i<len;i++){
				var item:DisplayObject=items[i];
				var point:Point3D=view.getChildPoint3D(item);
				
				var cameraZoomPos:Point3D=camera.position.clone();
				var comPoint:Point3D=point.clone();
				comPoint.rotateXYZTrig(rxCos,rxSin,ryCos,rySin,rzCos,rzSin);
				
				comPoint.minus(cameraZoomPos);
				comPoint.rotateXYZTrig(pitchCos,pitchSin,yawCos,yawSin,rollCos,rollSin);
				
				if(comPoint.z<-camera.zoom*300){
					item.visible=false
					continue
				}else{
					if(!item.visible){
						item.visible=true;
					}
				}
				
				var scaleValue:Number= comPoint.getPerspective(camera.zoom*300)
				var projectedPoint=comPoint.persProjectNew(scaleValue);
				item.scaleX=item.scaleY=scaleValue;
				item.x=projectedPoint.x;
				item.y=projectedPoint.y;
				sortArr.push({z:comPoint.z,item:item});
				
			}
			
			//////////////////////////////////////////////////////////////
			// sort depth
			//////////////////////////////////////////////////////////////
			sortArr.sortOn("z",Array.DESCENDING|Array.NUMERIC);
			
			for(var j:int=0,sourArrLen:int=sortArr.length;j<sourArrLen;j++){
				view.setChildDepth(sortArr[j].item,j);
			}
		}
		
		
	}
}