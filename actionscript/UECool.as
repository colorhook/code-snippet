package {
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import com.colorhook.spring.context.ContextLoader;
	import com.colorhook.spring.context.ContextInfo;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.*;
	import org.papervision3d.core.effects.*;
	import org.papervision3d.core.effects.utils.BitmapDrawCommand;

		
	import org.papervision3d.materials.*;
	import org.papervision3d.events.*;
	import org.papervision3d.lights.*;
	import org.papervision3d.materials.special.*;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.objects.special.*;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.layer.BitmapEffectLayer;
	
	[SWF(width=1024, height=768, frameRate=12)]
	public class UECool extends BasicView {

		public static const MAX_RADIUS:int = 20000;
		public static const PIXEL_NUM:int = 24;
		public static const PLANE_MARGIN:int = 0;
		public static const PLANE_SIZE:int = 100;
		public static const IMAGE_LIST:Array = [
[
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0],
[0,0,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0],
[0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0],
[0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0],
[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0],
[0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],
[0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0],
[0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0],
[0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
],

		[
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0],
[0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0],
[0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,0,1,0,0],
[0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0],
[0,0,0,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0]
],
		
		[
[0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0],
[0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0],
[0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0],
[0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0],
[0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0],
[0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0],
[0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0],
[0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],
[0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0],
[0,0,0,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0],
[0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0],
[0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0],
[0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0],
[0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0],
[0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0],
[0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0],
[0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
],
		
		[
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0],
[0,1,1,1,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0],
[1,1,1,0,0,1,1,1,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,0],
[1,1,1,1,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,0,0,1,1,1],
[0,1,1,1,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,0,0,1,1,1],
[1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1],
[1,1,1,1,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,0,0,1,1,1],
[1,1,1,1,0,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,1,1,1],
[0,0,0,0,0,1,1,0,0,0,1,1,0,1,1,1,1,0,0,0,0,1,1,1],
[1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,0,0,0,1,1,1,1,1],
[1,1,1,1,0,1,1,1,1,1,1,1,0,0,1,0,0,0,0,1,1,1,1,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,1,1,1,1,0,0,0,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0],
[0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,0,0,1,1,1,0,0],
[0,0,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,0,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,0,0,1,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,0,1,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,1,1,1,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0],
[0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0],
[0,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,0]
]
		
,
[
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[1,1,0,0,0,1,1,0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0],
[1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
[1,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,1,0],
[1,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,1,0],
[1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,0,0,0,1,1,0],
[1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,0,0,0,1,1,0],
[1,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,1,0],
[1,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,1,0],
[1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
[0,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
]


			
		];
		
		private var bfx:BitmapEffectLayer;
		private var dmyObjs:Array = [];
		private var dmyPixels:Array = [];
		private var index:int = 0;
		private var pixelArr:Array = [];
		private var uedPhotoes:Array;
		private var materials:Array = [];
		private var materialPlaneMap = new Dictionary();
		private var materialLoadedCount:int = 0;
		private var initPositionArr:Array = [];
		
		private var effectSound3D01:Sound3D;
		private var effectSound3D02:Sound3D;
		
		public function UECool() {
			stage.quality = StageQuality.LOW;
			stage.scaleMode = "noScale";
			try{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			}catch(e:*){
				stage.addEventListener("click", onStageMouseClicked);
			}
			super(0, 0, true, false, CameraType.FREE);
			
			viewport.opaqueBackground = 0x0;
			
			// create the effect layer
			bfx = new BitmapEffectLayer(viewport, stage.stageWidth, stage.stageHeight);
			bfx.addEffect(new BitmapLayerEffect(new BlurFilter(16,16, 4)));
			bfx.clippingPoint = new Point(0, 0);
			
			camera.focus = 150;
			camera.zoom = 4.5;
			
			var loader:ContextLoader = new ContextLoader();
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load("assets/head.xml");
		}
		
		private function onStageMouseClicked(e:MouseEvent):void{
			stage.removeEventListener("click", onStageMouseClicked);
			try{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			}catch(error:*){}
		}
		
		private function onLoaderComplete(e:Event):void{
			var contextInfo:ContextInfo = e.target.contextInfo;
			e.target.removeEventListener(Event.COMPLETE, onLoaderComplete);
			uedPhotoes = contextInfo.getBean("uedPhotoes");
			
			var sound:* = contextInfo.getBean("uedSound");
			sound.play(0, 100);
			effectSound3D01 = new Sound3D(contextInfo.getBean("effectSound01"));
			effectSound3D02 = new Sound3D(contextInfo.getBean("effectSound02"));
			scene.addChild(effectSound3D01);
			scene.addChild(effectSound3D02);
			init();
			startRendering();
			
		}
		
		private function init3DEffect():void{
			viewport.containerSprite.addLayer(bfx);
			loop();
		}

		private function getRandomPos():Object {
			return {
					x: MAX_RADIUS * (Math.random() - 0.5),
					y: MAX_RADIUS * (Math.random() - 0.5),
					z: MAX_RADIUS * (Math.random() - 0.5)
				};
		}
		private function getRandomValue(n:Number):Number {
			if(isNaN(n)){
				n = MAX_RADIUS;
			}
			return n * (Math.random() - 0.5);

		}
		/**
		 * 初始化照片停留位置的数组。照片有108张，分成12 * 9的高宽排列。 
		 */
		private function fillInitPositionArr():void{
			var w:int = 12, h:int = 9;
			initPositionArr = [];
			for(var i:int = 0; i< w * h; i++){
				var px:int = i%w;
				var py:int = (i-px)/w;
				initPositionArr[i] = {x: px, y: py};
			}
		}
		/**
		 * 随机取得一个空余的照片停留位置
		 */
		private function getNextPositionOfPhoto():*{
			var r:int = Math.floor(Math.random()*initPositionArr.length);
			var v:* = initPositionArr[r];
			initPositionArr.splice(r, 1);
			return {x:-535+v.x*100, y:-400+v.y*100};
		}
		/**
		 * 每当一张照片加载完成之后，则执行此回调函数。
		 * 如果照片全部加载完成，则停留N秒钟后开始3D特效。
 		 */
		private function onMaterialFileLoaded(event:FileLoadEvent):void{
			materialLoadedCount++;
			event.target.removeEventListener(FileLoadEvent.LOAD_COMPLETE, onMaterialFileLoaded);
			var plane:* = materialPlaneMap[event.target];
			plane.z = -1000;
			plane.x = getRandomValue(1000);
			plane.y = getRandomValue(1000);
			plane.rotationX = getRandomValue(1000);
			plane.rotationY = getRandomValue(1000);
			plane.rotationX = getRandomValue(1000);
			var pos = this.getNextPositionOfPhoto();
			BetweenAS3.to(plane, {
				x: pos.x,
				y: pos.y,
				rotationX: 0,
				rotationY: 0,
				rotationZ: 0,
				z: -100}, 2, Sine.easeOut).play();
			
			if(materialLoadedCount == uedPhotoes.length){
				var self = this;
				setTimeout(function(){
					self.init3DEffect();
				}, 3000);
			}
		}
		/**
		 * 建造3D星空。
		 */
		private function fillStars():void{
			var stars:ParticleField = new ParticleField(new MovieAssetParticleMaterial("StarMC", true), 500, 2, MAX_RADIUS * 3, MAX_RADIUS * 3, MAX_RADIUS * 3);
			scene.addChild(stars);
		}
		/**
		 * 建造3D星空，矩形粒子墙， 和拼接成型的粒子占位符。
		 */
		private function init():void {
			fillStars();
			
			fillInitPositionArr();
			for(var mi:int = 0; mi< uedPhotoes.length;mi++){
				var material:BitmapFileMaterial = new BitmapFileMaterial(uedPhotoes[mi]);
				material.addEventListener(FileLoadEvent.LOAD_COMPLETE, onMaterialFileLoaded);
				materials.push(material);
			}
												
			var p:int = 0, photoesLen = uedPhotoes.length;
			for (var i:int = 0; i < PIXEL_NUM; i++) {
				pixelArr[i] = [];
				for (var j:int = 0; j < PIXEL_NUM; j++) {
					var urlIndex:int = p%(photoesLen);p++;
					material = materials[urlIndex];
					material.oneSide = false;
					material.smooth = true;
					var o:Plane = new Plane(material, PLANE_SIZE, PLANE_SIZE);
					o.z = -10000;
					if(!materialPlaneMap[material]){
						materialPlaneMap[material] = o;
					}
					scene.addChild(o);
					pixelArr[i][j] = o;
					bfx.addDisplayObject3D(o);
				}
			}

			for (var k:int = 0; k < IMAGE_LIST.length; k++) {
				dmyObjs[k] = new DisplayObject3D();
				dmyObjs[k].x = MAX_RADIUS * (Math.random() - 0.5);
				dmyObjs[k].y = MAX_RADIUS * (Math.random() - 0.5);
				dmyObjs[k].z = MAX_RADIUS * (Math.random() - 0.5);
				dmyObjs[k].rotationX = 360 * Math.random();
				dmyObjs[k].rotationY = 360 * Math.random();
				dmyObjs[k].rotationZ = 360 * Math.random();

				scene.addChild(dmyObjs[k]);

				dmyPixels[k] = [];

				for (i = 0; i < PIXEL_NUM; i++) {
					dmyPixels[k][i] = [];

					for (j = 0; j < PIXEL_NUM; j++) {
						dmyPixels[k][i][j] = new DisplayObject3D();
						dmyPixels[k][i][j].x = (+i - PIXEL_NUM / 2) * (PLANE_SIZE + PLANE_MARGIN);
						dmyPixels[k][i][j].y = (-j + PIXEL_NUM / 2) * (PLANE_SIZE + PLANE_MARGIN) - 60;
						dmyObjs[k].addChild(dmyPixels[k][i][j]);
					}
				}
			}
			
		}
		
		

		private function loop(e:* = null):void {
			
			if (index == IMAGE_LIST.length){
				this.onEffectEnd();
				return;
			}

			var cameraTarget:DisplayObject3D = new DisplayObject3D();
			cameraTarget.copyTransform(dmyObjs[index]);
			cameraTarget.moveBackward(2500);
			
			var rp:* = getRandomPos();
			rp.z = -3000;
			var tween:* = BetweenAS3.parallel(
				BetweenAS3.delay(
				BetweenAS3.bezier(camera, {
					x: cameraTarget.x,
					y: cameraTarget.y,
					z: cameraTarget.z,
					rotationX: cameraTarget.rotationX,
					rotationY: cameraTarget.rotationY,
					rotationZ: cameraTarget.rotationZ
				}, null, rp, 6.5, Quint.easeInOut),
				1.4)
			);
			var self = this;
			tween.onComplete = function(){
				setTimeout(loop, 5000);
			}
			tween.play();
			
			for (var i:int = 0; i < PIXEL_NUM; i++) {
				for (var j:int = 0; j < PIXEL_NUM; j++) {
					var o:DisplayObject3D = pixelArr[i][j];
					var t:DisplayObject3D = dmyPixels[index][j][i];
					var s:Object = IMAGE_LIST[index][i][j];

					BetweenAS3.delay(
						BetweenAS3.bezier(o, {
							x: t.sceneX,
							y: t.sceneY,
							z: t.sceneZ,
							scale: s,
							rotationX: dmyObjs[index].rotationX,
							rotationY: dmyObjs[index].rotationY,
							rotationZ: dmyObjs[index].rotationZ
						}, null, getRandomPos(), 7 + Math.random(), Circular.easeInOut),
						Math.random() * 1).play();
				}
			}
			bfx.clippingPoint = new Point(0, 0);
			bfx.drawCommand = new BitmapDrawCommand(null, new ColorTransform(0.7, 0.4, 1, 0.05), BlendMode.ADD);
			

			setTimeout(function():void{
				effectSound3D02.x = camera.x;
				effectSound3D02.y = camera.y;
				effectSound3D02.z = camera.z;
				effectSound3D02.play(0);
				bfx.drawCommand = new BitmapDrawCommand(null, new ColorTransform(0.7, 0.4, 1, 1), BlendMode.ADD);
				bfx.clippingPoint = new Point(0,-10);
			}, 1000);
			setTimeout(function(){
				effectSound3D01.x = camera.x;
				effectSound3D01.y = camera.y;
				effectSound3D01.z = camera.z;
				effectSound3D01.play(0);
			}, 4000);
			setTimeout(function():void{
				bfx.drawCommand = new BitmapDrawCommand(null, new ColorTransform(0.9, 0.8, 1, 0), BlendMode.ADD);
				bfx.clippingPoint = new Point(0, -10);
			}, 6000);
			index++;
		}
		
		private function onEffectEnd():void{
			stopRendering();
		}
	}
}
