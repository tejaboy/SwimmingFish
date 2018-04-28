package game
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.net.SharedObject;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class gamePopup 
	{
		private var main;
		private var _stage;
		private var self;
		
		public function gamePopup(mainLocal, _stageLocal)
		{
			main = mainLocal;
			_stage = _stageLocal;
			self = main.popup_mc;
			
			self.popupClose_mc.addEventListener(MouseEvent.CLICK, closePopup);
		}
		
		public function showPopup(msg:String):void
		{
			var popup:TweenMax = new TweenMax(self, 1.5, {x: 512, ease:Elastic.easeOut});
			
			self.errorMsg_txt.text = msg;
		}
		
		public function closePopup(evt:MouseEvent = null):void
		{
			var popup:TweenMax = new TweenMax(self, 1.5, {x: 1668.45, ease:Elastic.easeOut});
			
			self.errorMsg_txt.text = "No errors. This shouldn't be displayed at all ... :/";
		}
	}
}
