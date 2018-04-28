// Default game button.
// Instead of creating mutiple buttons in the library, I challenged myself to create a dynamically button class for some fun.
// Oh! And have fun looking at the script by the way! :)

package game
{
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class gameButton
	{
		private var controller;
		private var clickLocation;
		private var main;
		private var enableAlpha;
		
		public function gameButton(tree, btnText, posX, posY, func, enableAlphaLocal = false)
		{
			enableAlpha = enableAlphaLocal;
			
			controller = tree.addChild(new buttonTemplate_mc());
			controller.x = posX;
			controller.y = posY;
			controller.border_text.text = btnText;
			controller.inner_text.text = controller.border_text.text;
			controller.stop();
			
			controller.addEventListener(MouseEvent.CLICK, func);
			controller.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			controller.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			
			if (enableAlpha)
			{
				controller.alpha = 0.6;
			}
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			controller.nextFrame();
		}
		
		private function overHandler(evt:MouseEvent):void
		{
			controller.nextFrame();
			
			if (enableAlpha)
			{
				controller.alpha = 1;
			}
		}
		
		private function outHandler(evt:MouseEvent):void
		{
			controller.prevFrame();
			
			if (enableAlpha)
			{
				controller.alpha = 0.6;
			}
		}
	}
}
