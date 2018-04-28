// Enemies class. No explanation needed, do you?

package game
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import cc.cote.airbag.*;
	import cc.cote.airbag.AirBag;
	import cc.cote.airbag.AirBagEvent;
	
	public class gameEnemies
	{
		private var obj:MovieClip;
		private var _stage;
		private var main;
		public var collisionChecker:AirBag = new AirBag();
		
		public function gameEnemies(mc, mainLocal, stageLocal)
		{
			_stage = stageLocal;
			main = mainLocal;
			obj = new mc;
			
			obj.name = "boat" + main.totalSpawnedObjects + "_mc";
			obj.x = 1024 + Math.floor(Math.random() * 11);
			obj.y = Math.floor(Math.random() * 799);
			obj["xMovement"] = main.randomRange(-3, -8);
			obj["yMovement"] = main.randomRange(-6, 6);
			
			do
			{
				obj["rotationValue"] = main.randomRange(-6, 6);
			}
			while (obj["rotationValue"] == 0)
			
			main.enemiesContainer_mc.addChild(obj);
			collisionChecker.add(obj, main.player_mc);
			
			main.addEventListener(Event.ENTER_FRAME, _process);
		}
		
		private function _process(evt:Event):void
		{
			// Move the object
			obj.x += obj["xMovement"] * main.speed;
			obj.y += obj["yMovement"] * main.speed;
			obj.rotation += obj["rotationValue"]
			
			if (obj.y <= 0 || obj.y >= _stage.stageHeight)
			{
				obj["yMovement"] = -obj["yMovement"];
			}
			
			checkCollisions();
			
			if (main.gameEnded == true || obj.x <= 0)
			{
				main.removeEventListener(Event.ENTER_FRAME, _process);
				main.enemiesContainer_mc.removeChild(obj);
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

	}
}
