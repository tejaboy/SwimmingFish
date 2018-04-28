// Player class. Responsible for most things that the player_mc MovieClip do.
// Only one of this class should be created. Unless we're talking about mutiplayer which is out of the scope of this assignment, sadly.

package game
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.freeactionscript.Bubbles;
	import cc.cote.airbag.*;
	import cc.cote.airbag.AirBag;
	import cc.cote.airbag.AirBagEvent;
	import flash.geom.Matrix;
	
	public class gamePlayer
	{
		public var playerClicked:Boolean = false;
		public var playerRotation:TweenMax;
		private var player_mc;
		private var _stage;
		
		// Setup dropping timer - after clicking
		var dropTimer:Timer = new Timer(240, 1);
		
		public function gamePlayer(actor, stageLocal)
		{
			player_mc = actor;
			_stage = stageLocal;
		}
		
		public function mouseClicked(evt:MouseEvent)
		{
			playerClicked = true;
			
			playerRotation = new TweenMax(player_mc, 0.6, {rotation: -40, ease:None.easeNone});
		}
		
		public function mouseReleased(evt:MouseEvent)
		{
			playerRotation.kill();
			playerRotation = new TweenMax(player_mc, 0.6, {rotation: 0, ease:Bounce.easeOut});
			
			dropTimer.start();
			dropTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dropEnabled);
		}
		
		public function dropEnabled(evt:TimerEvent)
		{
			dropTimer.stop();
			dropTimer.removeEventListener(TimerEvent.TIMER, dropEnabled);
			playerClicked = false;
		}
		
		public function playerControls()
		{
			var playerSpeed = 8;
			
			// If player is not touching the top or bottom, normal movement.
			if (player_mc.y >= 0 && player_mc.y <= _stage.stageHeight)
			{
				if (playerClicked == true)
				{
					player_mc.y +=  -playerSpeed;
				}
				else
				{
					player_mc.y += playerSpeed;
				}
			}
			
			// If player is touching the top wall but click is not enabled, lower the player - but never go up.
			if (player_mc.y <= 0)
			{
				player_mc.y += playerSpeed;
			}
			
			// If player is touching the bottom wall, and click is enabled, move up - but never lower.
			if (player_mc.y >= _stage.stageHeight)
			{
				if (playerClicked == true)
				{
					player_mc.y +=  -playerSpeed;
				}
			}
		}
		
		// Misc
		public function getX():Number
		{
			return player_mc.x;
		}
		
		public function getY():Number
		{
			return player_mc.y;
		}
	}
}
