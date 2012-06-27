package com.kouobei.luckygauge {
	
	import com.gskinner.motion.easing.Back;
	import com.gskinner.motion.easing.Bounce;
	import com.gskinner.motion.easing.Cubic;
	import com.gskinner.motion.easing.Exponential;
	import com.gskinner.motion.easing.Quadratic;
	import com.gskinner.motion.easing.Quintic;
	import com.gskinner.motion.easing.Sine;
	import com.gskinner.motion.easing.Linear;
	import com.gskinner.motion.easing.Elastic;
	import com.gskinner.motion.plugins.ColorTransformPlugin;
	import com.kouobei.luckygauge.model.ModelLocator;
	import com.kouobei.luckygauge.service.IServiceDelegate;
	import com.kouobei.luckygauge.service.MockupServiceDelegate;
	import com.kouobei.luckygauge.service.ServiceDelegate;
	import com.kouobei.luckygauge.utils.ILogger;
	import com.kouobei.luckygauge.utils.Logger;
	import com.kouobei.luckygauge.utils.NullLogger;
	import com.kouobei.luckygauge.utils.MotionHelper;
	import com.kouobei.luckygauge.view.GaugeView;
	import com.kouobei.luckygauge.view.MockupGaugeView;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.filters.BlurFilter;
	import flash.system.Security;
	import flash.system.System;
	import flash.utils.Timer;
	import com.gskinner.motion.GTweener;
	
	/**
	 * @
	 * @author 正邪
	 */
	public class LuckyGauge extends Sprite {
		
		protected var gaugeView:GaugeView;
		protected var model:ModelLocator;
		protected var serviceDelegate:IServiceDelegate;
		protected var logger:ILogger;
		protected var timer:Timer;
		
		private static var TIMER_DURATION:Number = 10;
		private static var SPEED_UP_DURATION:Number=2;
		private static var SPEED_DOWN_DURATION:Number=8;
		private static var SPEED_FULL_DURATION:Number = 0.2;
		private static var MAX_ROTATE_SPEED:Number = 18;
		private static var REQUEST_TIMEOUT:Number = 20;
		
		private var animParams:*;
		private var usedTime:Number;
		private var targetAngle:Number; 
	
		/**
		 * represent the phase of rotation.
		 * 0 indicate the animation is not start yet.
		 * 1 indicate the speed up phase.
		 * 2 indicate the speed full phase.
		 * 3 indicate the speed down phase.
		 */
		private var speedPhase:int = 0;
		
		/**
		 * constructor
		 */
		public function LuckyGauge() {
			Security.allowDomain('*.koubei.com');
			Security.allowDomain('k.kbcdn.com');
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		/**
		 * remove event Event.ADDED_TO_STAGE and initialize game.
		 * @param	e
		 */
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initializeData();
			callJS('ready');
			initializeGame();
		}
		
		private function initializeData():void {
			model = ModelLocator.getInstance();
			if (!loaderInfo || !loaderInfo.parameters) {
				return;
			}
			var p:*= loaderInfo.parameters;
			if (p.kbToken) {
				model.kbToken = p.kbToken;
			}
			if (p.yui_id) {
				model.yui_id = p.yui_id;
			}
			if (p.hasSignup) {
				model.hasSignup = Boolean(p.hasSignup);
			}
			if (p.username) {
				model.username = p.username;
			}
			if (p.endpoint) {
				ServiceDelegate.ENDPOINT = p.endpoint;
			}
			if (p.speedUpDuration) {
				SPEED_UP_DURATION = Number(p.speedUpDuration);
			}
			if (p.speedDownDuration) {
				SPEED_DOWN_DURATION = Number(p.speedDownDuration);
			}
			if (p.speedFullDuration) {
				SPEED_FULL_DURATION = Number(p.speedFullDuration);
			}
			if (p.requestTimeout) {
				REQUEST_TIMEOUT = Number(p.requestTimeout);
			}
		}
		/**
		 * instantiate Model, View and Service Delegate.
		 * register model events.
		 */
		protected function initializeGame():void {
			
			gaugeView = new GaugeView;
			gaugeView.visible = false;
			gaugeView.pointer_layer.pointer.rotation = -60;
			gaugeView.panel_user.visible = gaugeView.panel_guest.visible = false;
			gaugeView.runEnabled = false;
			addChild(DisplayObject(gaugeView));
			
			timer = new Timer(TIMER_DURATION);
			
			logger = new NullLogger;
			model.addEventListener(ModelLocator.SERVICE_FAULT, onSeviceFault);
			model.addEventListener(ModelLocator.SERVICE_RESULT, onServiceResult);
			model.addEventListener(ModelLocator.PRIZE_DATA_CHANGED, onPrizeDataChanged);
			model.addEventListener(ModelLocator.AVAIABLE_COUNT_CHANGE, onAvaiableCountChanged);
			model.addEventListener(ModelLocator.INITIALIZED, onGameReady);

		
			serviceDelegate = new ServiceDelegate();
			//serviceDelegate = new MockupServiceDelegate;
			
			
			if (model.kbToken) {
				serviceDelegate.shakeHand();
			}else {
				onGameReady()
			}
			
		}
		
		private function onGameReady(e:Event = null):void {
			model.removeEventListener(ModelLocator.INITIALIZED, onGameReady);
			
			gaugeView.visible = true;
			gaugeView.runEnabled = true;
			if (model.hasSignup) {
				callJS("prizeDataChanged", model.prizeData);
				gaugeView.panel_user.visible = true;
				gaugeView.panel_user.username_tf.text = model.username;
				gaugeView.updateAvaiableCount(String(model.avaiableCount));
				gaugeView.runButton.addEventListener(MouseEvent.CLICK, onRunButtonClicked);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				reset();
			}else {
				gaugeView.panel_guest.visible = true;
				initWhileNoUser();
				/**/gaugeView.runButton.addEventListener(MouseEvent.CLICK, onLoginButtonClicked);
				/*/gaugeView.runButton.addEventListener(MouseEvent.CLICK, onRunButtonClicked);
				//*/
				gaugeView.panel_guest.getChildByName('login_btn').addEventListener(MouseEvent.CLICK, onLoginButtonClicked);
			}
			
			
		}
		private function initWhileNoUser(e:*= null):void {
			var p:*= gaugeView.pointer_layer.pointer;
			var time:Number = 2 ;
			var _rotation:Number = p.rotation + 90;
			var owner:*= this;
			GTweener.to(p, time, { rotation:_rotation }, { 
				ease:Linear.easeNone,
				onComplete:owner.initWhileNoUser
			});
		}
		/*
		private function initWhileNoUser(e:*=null):void {
			var p:*= gaugeView.pointer_layer.pointer;
			var time:Number = 1 + Math.random() * 4;
			var _rotation:Number = 90 + Math.random() * 600;
			var owner:*= this;
			GTweener.to(p, time, { rotation:_rotation }, { 
				ease:Sine.easeOut,
				onComplete:function(event:*):void {
					GTweener.to(null, 1, null, {
						onComplete:owner.initWhileNoUser
					});
				}
			});
		}*/
		private function onPrizeDataChanged(e:Event):void {
			if (!model.playing) {
				callJS("prizeDataChanged", model.prizeData);
			}
		}

		private function onLoginButtonClicked(event:MouseEvent):void {
			callJS('onLoginClicked');
			gaugeView.runEnabled = true;
		}
		/**
		 * handle the run button click event.
		 * @param	event
		 */
		private function onRunButtonClicked(event:MouseEvent):void {
			if (model.playing) {
				return;
			}
			if (model.hasSignup) {
				if (model.avaiableCount > 0) {
					serviceDelegate.doService();
				}else {
					callJS('showPrize', ['noChance', null, null, null, model.tomorrowcount]);
					gaugeView.runEnabled = true;
					return;
				}
				
			}else {
				model.setRandomPrize();
				targetAngle = MotionHelper.getRotateByPrizeNo(model.prize);
			}
			run();
		}
		/**
		 * run the lucky gauge
		 */
		private function run():void {
			gaugeView.stopBlink();
			
			model.playing = true;
			speedPhase = 1;
			animParams = { currentSpeed:0 };
			timer.start();
			
			GTweener.to(animParams, SPEED_UP_DURATION, 
						{ currentSpeed:MAX_ROTATE_SPEED }, 
						{ onComplete:this.onSpeedUpPhaseEnd } );
			logger.info('start speed up');
		}
		/**
		 * stop running and reset game state.
		 */
		private function reset():void {
			model.playing = false;
			targetAngle = NaN;
			speedPhase = 0;
			timer.reset();
			usedTime = 0;
			gaugeView.reset();
		}
		/**
		 * timer event handler
		 * @param	e
		 */
		private var timeFromSpeedDown:Number = 0;
		private function onTimer(e:TimerEvent):void {
			if (speedPhase == 3) {
				return;
			}
			gaugeView.pRotation=animParams.currentSpeed;
		}
		/**
		 * while the speed up phase end
		 * @param	e
		 */
		private function onSpeedUpPhaseEnd(e:*):void {
			speedPhase = 2;
			usedTime = SPEED_UP_DURATION + SPEED_FULL_DURATION;
			GTweener.to(null, SPEED_FULL_DURATION, null, 
					{ onComplete:this.onSpeedFullPhaseEnd } );
			logger.info('start speed full');
		}
		/**
		 * while the speed full phase end.
		 * If the server response not availabe yet, continue full speed.
		 * Else if the server response timeout, tell user the service is not avaiable right now.
		 * Else go to the speed down phase.
		 * @param	e
		 */
		private function onSpeedFullPhaseEnd(e:*):void {
			
			if (isNaN(targetAngle)) {
				var extraDuration:Number = 0.1;
				usedTime += extraDuration;
				if (usedTime > REQUEST_TIMEOUT) {
					this.onServiceTimeout();
					return;
				}
				GTweener.to(null, extraDuration, null, 
						{ onComplete:this.onSpeedFullPhaseEnd } );
			}else {
				targetRotation = getSpeedDownRotation(targetAngle);
				animParams.tRotation = gaugeView.pointer_layer.pointer.rotation;
				animParams.previoustRotation = animParams.tRotation;
				GTweener.to(animParams, SPEED_DOWN_DURATION, { tRotation:targetRotation }, {
					onComplete:this.onSpeedDownPhaseEnd,
					onChange:this.onSpeedDownUpdate,
					ease:Sine.easeOut
				});
				logger.info('start speed down');
			}
			
		}
		private function onSpeedDownUpdate(e:*):void {
			animParams.currentSpeed = animParams.tRotation - animParams.previoustRotation;
			animParams.previoustRotation = animParams.tRotation;
			gaugeView.pRotation = animParams.currentSpeed;
			gaugeView.pointer_layer.pointer.rotation=animParams.tRotation
		}
		/**
		 * while the speed down phase end.
		 * @param	e
		 */
		private function onSpeedDownPhaseEnd(e:*= null):void {
			gaugeView.pointer_layer.pointer.rotation = targetRotation;
			reset();
			var m:*= model.convertPrizeData(Number(model.prize));
			var blinkMap:*= {
				"0": 1,
				"1": 4,
				"2": 5,
				"3": 2,
				"4": 3,
				"5": 3,
				"6": 3,
				"7": 3,
				"8": 3,
				"9": 0
			}
			this.onGameEnd();
			gaugeView.startBlink(blinkMap[model.prize]);
			if (model.prize != null) {
				callJS('showPrize', [m.prize, m.param, model.hasSignup, model.deliveryid, model.tomorrowcount]);
			}
		}
		private function onGameEnd():void {
			gaugeView.clearAllEffects();
			gaugeView.runEnabled = true;
			gaugeView.updateAvaiableCount(String(model.avaiableCount));
			callJS("prizeDataChanged", model.prizeData);
		}
		private var targetRotation:Number;
		/**
		 * compute a suitable rotation by the parameter target angle.
		 * @param	targetAngle
		 * @return 	Number
		 */
		private function getSpeedDownRotation(targetAngle:Number):Number {
			var factor:Number = 0.5;
			var rEachSecond:Number = 1000 / TIMER_DURATION * MAX_ROTATE_SPEED;
			var maxRotation:Number = rEachSecond * SPEED_DOWN_DURATION * factor;
			var temp:Number = maxRotation % 360;
			if (temp > targetAngle) {
				return maxRotation - temp +targetAngle;
			}
			return maxRotation - temp - 360 + targetAngle;
		}
		
		/**
		 * handle the service fault.
		 * @param	e
		 */
		private function onSeviceFault(e:Event):void {
			reset();
			gaugeView.pointer_layer.visible = false;
			gaugeView.visible = false;
			GTweener.removeTweens(null);
			GTweener.removeTweens(animParams);
			gaugeView.runButton.removeEventListener(MouseEvent.CLICK, onRunButtonClicked);
			callJS('onFault');		
		}
		/**
		 * handle the service result.
		 * @param	e
		 */
		private function onServiceResult(e:Event):void {
			callJS('onResponse', model.response);
			if (model.code == '300') {
				reset();
				gaugeView.pointer_layer.pointer.rotation = 0;
				callJS('showPrize',['noChance', null, null,null, model.tomorrowcount]);
				return;
			}
			targetAngle = MotionHelper.getRotateByPrizeNo(model.prize);
		}
		/**
		 * handle the service timeout.
		 */
		private function onServiceTimeout():void {
			onSeviceFault(null);
		}
		/**
		 * execute while the avaibale count changed.
		 */ 
		private function onAvaiableCountChanged(e:Event):void {
			
		}
		
		private function callJS(func:String, params:*=null):void {
			if (ExternalInterface.available) {
				try{
				ExternalInterface.call('YUI.swf.call', (model.yui_id || 'lucky-guage'), func, params);
				}catch(error:SecurityError){}
			}
		}
	}
}