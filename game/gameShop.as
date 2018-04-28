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
	
	public class gameShop
	{
		// Buttons for shop
		private var shopBuy:Object = new Object();
		private var clickedItem;
		private var main;
		private var _stage;
		private var scrollArea;
		
		public function gameShop(mainLocal, _stageLocal)
		{
			main = mainLocal;
			_stage = _stageLocal;
			
			main.hudShop_mc.scrollArea_mc.source = new hudShopListing_mc;
			shopBuy["buy01"] = new gameButton(main.hudShop_mc, "Buy", 190, 220, buyItem, true);
			
			scrollArea = main.hudShop_mc.scrollArea_mc.source;
			
			refreshText();
			
			// Close button
			main.hudShop_mc.close_btn.addEventListener(MouseEvent.CLICK, closeHandler);
			
			// Mouse click handler
			scrollArea.item01_btn.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void { shopBuyBtnClickHandler(evt, scrollArea.item01_btn); } );
			scrollArea.item02_btn.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void { shopBuyBtnClickHandler(evt, scrollArea.item02_btn); } );
			scrollArea.item03_btn.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void { shopBuyBtnClickHandler(evt, scrollArea.item03_btn); } );
			scrollArea.item04_btn.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void { shopBuyBtnClickHandler(evt, scrollArea.item04_btn); } );
			scrollArea.item05_btn.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void { shopBuyBtnClickHandler(evt, scrollArea.item05_btn); } );
			
			// Mouse over handler
			scrollArea.item01_btn.addEventListener(MouseEvent.MOUSE_OVER, function (evt:MouseEvent):void { shopBuyBtnOverHandler(evt, scrollArea.item01_btn); } );
			scrollArea.item02_btn.addEventListener(MouseEvent.MOUSE_OVER, function (evt:MouseEvent):void { shopBuyBtnOverHandler(evt, scrollArea.item02_btn); } );
			scrollArea.item03_btn.addEventListener(MouseEvent.MOUSE_OVER, function (evt:MouseEvent):void { shopBuyBtnOverHandler(evt, scrollArea.item03_btn); } );
			scrollArea.item04_btn.addEventListener(MouseEvent.MOUSE_OVER, function (evt:MouseEvent):void { shopBuyBtnOverHandler(evt, scrollArea.item04_btn); } );
			scrollArea.item05_btn.addEventListener(MouseEvent.MOUSE_OVER, function (evt:MouseEvent):void { shopBuyBtnOverHandler(evt, scrollArea.item05_btn); } );
			
			// Mouse out handler
			scrollArea.item01_btn.addEventListener(MouseEvent.MOUSE_OUT, function (evt:MouseEvent):void { shopBuyBtnOutHandler(evt, scrollArea.item01_btn); } );
			scrollArea.item02_btn.addEventListener(MouseEvent.MOUSE_OUT, function (evt:MouseEvent):void { shopBuyBtnOutHandler(evt, scrollArea.item02_btn); } );
			scrollArea.item03_btn.addEventListener(MouseEvent.MOUSE_OUT, function (evt:MouseEvent):void { shopBuyBtnOutHandler(evt, scrollArea.item03_btn); } );
			scrollArea.item04_btn.addEventListener(MouseEvent.MOUSE_OUT, function (evt:MouseEvent):void { shopBuyBtnOutHandler(evt, scrollArea.item04_btn); } );
			scrollArea.item05_btn.addEventListener(MouseEvent.MOUSE_OUT, function (evt:MouseEvent):void { shopBuyBtnOutHandler(evt, scrollArea.item05_btn); } );
			
			function shopBuyBtnClickHandler(evt:MouseEvent, item):void
			{
				if (clickedItem != item)
				{
					if (clickedItem)
					{
						clickedItem.alpha = 0.9;
					}
					
					clickedItem = item;
					item.alpha = 0;
				}
				else
				{
					clickedItem = null;
					item.alpha = 0.6;
				}
			}
			
			function shopBuyBtnOverHandler(evt:MouseEvent, item):void
			{
				if (item != clickedItem)
				{
					item.alpha = 0.9;
				}
			}
			
			function shopBuyBtnOutHandler(evt:MouseEvent, item):void
			{
				if (item != clickedItem)
				{
					item.alpha = 0.6;
				}
			}
		}
		
		public function shopHandler(evt:MouseEvent = null):void
		{
			refreshText();
			main.hudShop_mc.close_btn.visible = true;
			var hudPanel:TweenMax = new TweenMax(main.hudPanel_mc, 2, {y: -362.15, ease:Regular.easeOut});
			var hudShop:TweenMax = new TweenMax(main.hudShop_mc, 2, {x: 512, y: 383.95, ease:Elastic.easeOut});
		}
		
		private function buyItem(evt:MouseEvent = null):void
		{
			var success = false;
			var errorMsg = "You do not have enough coins to purchase the items.";
			var cost;
			
			if (clickedItem == scrollArea.item01_btn)
			{
				// Cost: 1000;
				cost = 1000;
				if (main.gameCookie.data.coins >= cost)
				{
					main.gameCookie.data.shopItem01 += 1;
					success = true;
				}
			}
			else if (clickedItem == scrollArea.item02_btn)
			{
				// Cost: 1000;
				cost = 1000;
				if (main.gameCookie.data.coins >= cost)
				{
					main.gameCookie.data.shopItem02 += 1;
					success = true;
				}
			}
			else if (clickedItem == scrollArea.item03_btn)
			{
				// Cost: 500;
				cost = 500;
				if (main.gameCookie.data.coins >= cost)
				{
					main.gameCookie.data.shopItem03 += 1;
					success = true;
				}
			}
			else if (clickedItem == scrollArea.item04_btn)
			{
				// Cost: 2000;
				cost = 2000;
				if (main.gameCookie.data.coins >= cost)
				{
					main.gameCookie.data.shopItem04 += 1;
					success = true;
				}
			}
			else if (clickedItem == scrollArea.item05_btn)
			{
				// Cost: 5000 to 3000;
				cost = 3000;
				if (main.gameCookie.data.coins >= cost)
				{
					main.gameCookie.data.shopItem05 += 1;
					success = true;
				}
			}
			else
			{
				success = false;
				errorMsg = "Our shop does not sell `nothing`, sadly.";
			}
			
			if (success == true)
			{
				main.gameCookie.data.coins -= cost;
				main.gameCookie.flush();
				
				refreshText();
			}
			else
			{
				main.popup.showPopup(errorMsg);
			}
		}
		
		private function refreshText():void
		{
			scrollArea.item01Owned_text.text = "Owned: " + main.gameCookie.data.shopItem01;
			scrollArea.item02Owned_text.text = "Owned: " + main.gameCookie.data.shopItem02;
			scrollArea.item03Owned_text.text = "Owned: " + main.gameCookie.data.shopItem03;
			scrollArea.item04Owned_text.text = "Owned: " + main.gameCookie.data.shopItem04;
			scrollArea.item05Owned_text.text = "Owned: " + main.gameCookie.data.shopItem05;
			main.hudShop_mc.coinsBalance_txt.text = main.gameCookie.data.coins;
		}
		
		public function closeHandler(evt:MouseEvent = null):void
		{
			main.hudShop_mc.close_btn.visible = false; // Prevent a bug where the hudShop_mc will not be closed if the user keep clicking on the button.
			var hudShop:TweenMax = new TweenMax(main.hudShop_mc, 1.6, {x: -391.75, y: -362.15, ease:Elastic.easeIn, onComplete: closeHandler02});
			
			function closeHandler02():void
			{
				if (main.atMenu != true) // If user access the shop via the main menu, he/she shouldn't see hudPanel_mc at all.
				{
					var hudPanel:TweenMax = new TweenMax(main.hudPanel_mc, 2, {y: 383.95, ease:Elastic.easeOut});
				}
			}
		}
	}
}
