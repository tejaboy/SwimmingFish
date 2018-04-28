// Remember that 'AWESOME' screenshot that will always appear when you lose a game? This is the script responsible for it!

// Currentely, this class only capture a screenshot every 1.2 seconds and the screenshot to be show will always be the last captured screenshot.
// If time allowed (which I do not think so if you're reading this), I'd like to come up with a nice logic to display the best screenshot taken over the corse of the gameplay

package game
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import flash.geom.*;
	import flash.geom.Matrix;
	
	public class gameCamera
	{
		var cameraTimer:Timer;
		var scale = 1;
		var matrix:Matrix = new Matrix();
		public var screenshotData:BitmapData;
		var mainStage:Stage;
		var camera_mc:MovieClip;
		var player_mc:MovieClip;
		
		public function startCamera(localMain:Stage, localCamera:MovieClip, localPlayer:MovieClip)
		{
			cameraTimer = new Timer(1200, 1);
			
			cameraTimer.start();
			cameraTimer.addEventListener(TimerEvent.TIMER_COMPLETE, cameraHandler);
			
			mainStage = localMain;
			camera_mc = localCamera;
			player_mc = localPlayer;
			matrix.scale(scale, scale);
		}
		
		public function cameraHandler(evt:TimerEvent)
		{
			camera_mc.x = player_mc.x * 2 - 135;
			camera_mc.y = player_mc.y - 100;
			
			var bitmapdata:BitmapData = new BitmapData(mainStage.stageWidth, mainStage.stageHeight);

			bitmapdata.draw(mainStage);
			
			var bitmapDataA:BitmapData = new BitmapData(camera_mc.width, camera_mc.height);
			
			bitmapDataA.copyPixels(bitmapdata, new Rectangle(camera_mc.x, camera_mc.y, camera_mc.width, camera_mc.height), new Point(0, 0));
			
			screenshotData = bitmapDataA;
			
			cameraTimer.start();
		}
	}
}