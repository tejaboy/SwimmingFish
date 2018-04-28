// As per title, the class that is responsible for spawning those 'annoying' enemies. :)

package game
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import game.gameEnemies;
	
	public class gameSpawner
	{
		// Timer for spawning
		var objectsTimer:Object = new Object();
		var main;
		var _stage;
		
		public function gameSpawner(mainLocal, stageLocal)
		{
			main = mainLocal;
			_stage = stageLocal;
			
			objectsTimer["boat"] = new Timer(main.randomRange(3400, 6000), 1);
			objectsTimer["boat"].start();
			objectsTimer["boat"].addEventListener(TimerEvent.TIMER_COMPLETE, function (evt:TimerEvent) { objectsTimer["boat"].start(); spawnObjects(boat_mc, main.randomRange(1, 2), evt); } );
			
			objectsTimer["largeBullet"] = new Timer(main.randomRange(9000, 20000), 1);
			objectsTimer["largeBullet"].start();
			objectsTimer["largeBullet"].addEventListener(TimerEvent.TIMER_COMPLETE, function (evt:TimerEvent) { objectsTimer["largeBullet"].start(); spawnObjects(largeBullet_mc, 1, evt); } );
			
			spawnObjects(boat_mc, main.randomRange(1, 2));
			spawnObjects(largeBullet_mc, 1);
			
			main.addEventListener(Event.ENTER_FRAME, _process);
		}
		
		public function spawnObjects(mc:Class, amt:Number, evt:TimerEvent = null)
		{
			var localSpawnedAmt:Number = 0;
			
			while (localSpawnedAmt < amt)
			{
				if (mc == boat_mc)
				{
					new gameEnemies(mc, main, _stage);
					
					// Set-up new timer
					var randomTime = main.randomRange(3400, 6000) / (main.speed / (main.speed / 2));
					objectsTimer["boat"].delay = randomTime;
				}
				else if (mc == largeBullet_mc)
				{
					new gameMissile(mc, main, _stage);
				}
				
				main.totalSpawnedObjects++;
				main.totalActiveObjects++;
				localSpawnedAmt++;
			}
		}
		
		private function _process(evt:Event):void
		{
			if (main.gameEnded == true)
			{
				objectsTimer["boat"].stop();
				objectsTimer["largeBullet"].stop();
				objectsTimer["boat"].removeEventListener(TimerEvent.TIMER_COMPLETE, function (evt:TimerEvent) { objectsTimer["boat"].start(); spawnObjects(boat_mc, main.randomRange(1, 2), evt); } );
				objectsTimer["largeBullet"].removeEventListener(TimerEvent.TIMER_COMPLETE, function (evt:TimerEvent) { objectsTimer["largeBullet"].start(); spawnObjects(largeBullet_mc, 1, evt); } );
			}
		}
	}
}
