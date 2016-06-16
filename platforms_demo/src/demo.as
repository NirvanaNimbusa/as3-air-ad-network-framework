package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import so.cuo.platform.ad.*;
	import so.cuo.platform.ad.adapters.*;
	[SWF(width="960",height="640")]
	public class demo extends Sprite
	{
		public function demo()
		{
			super();
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var ui:UI=new UI(onClick);
			addChild(ui);
			ui.addButton("top", 0, 50);
			ui.addButton("abs", 200, 50);
			ui.addButton("hide", 0, 150);
			ui.addButton("Interstitial", 200, 150);
			ui.addButton("moreapp", 0, 250);
			ui.addButton("bottom", 200, 250);
			
			
			var list:Vector.<AdItem>=new Vector.<AdItem>();// 
			list.push(new AdItem(new BaiduAdapter("appid","banner id","insti id","video id","splash id"), 10,5));
			list.push(new AdItem(new AdmobAdapter("banner id","inst id"), 10,5));
			list.push(new AdItem(new InmobiAdapter("app id"), 10));
			list.push(new AdItem(new ChartboostAdapter("app id","app sign"), 10));
			list.push(new AdItem(new GDTAdapter("app id","banner id","insti id","more app id","splash id"), 10));
			list.push(new AdItem(new IAdAdapter(),10));
			AdManager.getInstance().configPlatforms(list);
			
			AdManager.getInstance().addEventListener(AdEvent.onBannerFailedReceive,onAdFailEvent);
			AdManager.getInstance().addEventListener(AdEvent.onInterstitialFailedReceive,onAdFailEvent);
			AdManager.getInstance().addEventListener(AdEvent.onInterstitialReceive,onInterstitialSuccessEvent);
		}
		
		protected function onInterstitialSuccessEvent(event:AdEvent):void
		{
			trace("load ad success"+event.type);
			AdManager.getInstance().showInterstitialOrCache();
		}
		
		private function onAdFailEvent(event:AdEvent):void
		{
			trace("load ad failed " + event.type +"  with event data:"+event.data);
		}

		private function onClick(label:String):void
		{
			trace("click:" + label);
			if (label == "top")
			{
				AdManager.getInstance().showBanner(AdSize.BANNER_STANDARD,AdPosition.TOP_CENTER);
			}
			else if (label == "bottom")
			{
				AdManager.getInstance().showBanner(AdSize.PHONE_PORTRAIT,AdPosition.BOTTOM_CENTER);
			}
			else if (label == "abs")
			{
				AdManager.getInstance().showBannerAbsolute(AdSize.PHONE_PORTRAIT,0,80);
			}
			else if (label == "hide")
			{
				AdManager.getInstance().hideBanner();
			}
			else if (label == "moreapp")
			{
				if(AdManager.getInstance().isMoreAppReady()){
					AdManager.getInstance().showMoreApp();
				}else{
					AdManager.getInstance().cacheMoreApp();
				}
			}
			else if (label == "Interstitial")
			{
				AdManager.getInstance().showInterstitialOrCache();
			}
		}
	}
}
