package game
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import com.greensock.*;
	import com.greensock.easing.*;
	import cc.cote.airbag.*;
	import cc.cote.airbag.AirBag;
	import cc.cote.airbag.AirBagEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import cc.cote.airbag.*;
	import cc.cote.airbag.AirBag;
	import cc.cote.airbag.AirBagEvent;
			
	public class gameMissile
	{
		private var obj:MovieClip;
		private var _stage;
		private var main;
		private var tempArrow;
		private var currentState = 0;
		public var collisionChecker:AirBag = new AirBag();
		
		public function gameMissile(mc, mainLocal, stageLocal)
		{
			_stage = stageLocal;
			main = mainLocal;
			
			tempArrow = new warningArrow_mc;
			tempArrow.x = 1024 - tempArrow.width;
			main.enemiesContainer_mc.addChild(tempArrow);
			
			var timer = new Timer(main.randomRange(2000, 3000), 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, preSpawnObject);
			
			main.addEventListener(Event.ENTER_FRAME, _process);
			
			function preSpawnObject(evt:TimerEvent)
			{
				currentState = 1;
				tempArrow.body_txt.text = "COMING!";
				tempChangeScaleBig();
				
				timer = new Timer(main.randomRange(2000, 3000), 1);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, spawnObject);
			}
			
			function spawnObject(evt:TimerEvent):void
			{
				currentState = 2;
				main.enemiesContainer_mc.removeChild(tempArrow);
				
				obj = new mc;
			
				obj.name = "missile" + main.totalSpawnedObjects + "_mc";
				obj.x = 1024 + Math.floor(Math.random() * 11);
				obj.y = main.player.getY();
				obj["xMovement"] = main.randomRange(-6, -12);
				
				main.enemiesContainer_mc.addChild(obj);
				collisionChecker.add(obj, main.player_mc);
				
				var soundURLRequest:URLRequest = new URLRequest("src/sound/SFX_Explosion_05.mp3");
				var sound:Sound = new Sound(soundURLRequest);
				sound.play();
			}
		}
		
		private function _process(evt:Event):void
		{
			// Move the object
			if (!obj || currentState == 0)
			{
				tempArrow.y = main.player.getY();
			}
			else
			{
				obj.x += obj["xMovement"] * main.speed;
				checkCollisions();
				
				if (main.gameEnded == true || obj.x <= 0)
				{
					main.removeEventListener(Event.ENTER_FRAME, _process);
					main.enemiesContainer_mc.removeChild(obj);
				}
			}
		}
		
		public function checkCollisions()
		{
			// Check for collisions with objects
			if (main.gameEnded == false)
			{
				var checkAirbag = collisionChecker.detect();
				
				if (checkAirbag.length)
				{
					collisionChecker.remove(obj);
					main.checkLose();
				}
			}
		}
		
		private function tempChangeScaleBig():void
		{
			var tween:TweenMax = new TweenMax(tempArrow, 0.5, {scaleX: 1.1, scaleY:1.1 , ease:Elastic.easeOut});
			
			TweenMax.delayedCall(0.5, tempChangeScaleSmall);
		}
		
		private function tempChangeScaleSmall():void
		{
			var tween:TweenMax = new TweenMax(tempArrow, 0.5, {scaleX: 1, scaleY:1 , ease:Elastic.easeOut});
			
			TweenMax.delayedCall(0.5, tempChangeScaleBig);
		}
	}
}
