package so.cuo.platform.ad.adapters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.ad.IMorePage;
	import so.cuo.platform.chartboost.Chartboost;
	import so.cuo.platform.chartboost.ChartboostEvent;

	
	[Event(name="onInterstitialDismiss", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialFailedReceive", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialLeaveApplication", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialPresent", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialReceive", type="so.cuo.platform.ad.AdEvent")]
	public class ChartboostAdapter extends EventDispatcher implements  IInterstitial,IMorePage
	{
		protected function get plat():Chartboost
		{
			return Chartboost.getInstance();
		}

		public function ChartboostAdapter()
		{
			plat.addEventListener(ChartboostEvent.onInterstitialDismiss, onAdHandler);
			plat.addEventListener(ChartboostEvent.onInterstitialFailedReceive, onAdHandler);
			plat.addEventListener(ChartboostEvent.onInterstitialLeaveApplication, onAdHandler);
			plat.addEventListener(ChartboostEvent.onInterstitialPresent, onAdHandler);
			plat.addEventListener(ChartboostEvent.onInterstitialReceive, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppDismiss, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppFailedReceive, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppLeaveApplication, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppLeaveApplication, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppPresent, onAdHandler);
			plat.addEventListener(ChartboostEvent.onMoreAppReceive, onAdHandler);
		}

		public function dispose():void
		{
			plat.removeEventListener(ChartboostEvent.onInterstitialDismiss, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onInterstitialFailedReceive, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onInterstitialLeaveApplication, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onInterstitialPresent, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onInterstitialReceive, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppDismiss, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppFailedReceive, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppLeaveApplication, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppLeaveApplication, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppPresent, onAdHandler);
			plat.removeEventListener(ChartboostEvent.onMoreAppReceive, onAdHandler);
			plat.dispose();
		}

		public function get supportDevice():Boolean
		{
			return plat.supportDevice;
		}

		/*public function get supportedBanner():Boolean
		{
			return false;
		}
*/
		public function get supportedMoreApp():Boolean
		{
			return plat.supportedMoreApp;
		}

		public function get supportedInterstitial():Boolean
		{
			return plat.supportedInterstitial;
		}

		public function setTesting(deviceID:String=null):void
		{
		}

		public function setInterstitialKeys(appID:String, key:String=null):void
		{
			plat.setInterstitialKeys(appID,key);
		}

		public function cacheInterstitial():void
		{
			plat.cacheInterstitial();
		}

		public function showInterstitial():void
		{
			plat.showInterstitial();
		}

		public function isInterstitialReady():Boolean
		{
			return plat.isInterstitialReady();
		}

		public function setMoreAppKeys(appID:String, key:String=null):void
		{
			plat.setMoreAppKeys(appID,key);
		}

		public function cacheMoreApp():void
		{
			plat.cacheMoreApp();
		}

		public function showMoreApp():void
		{
			plat.showMoreApp();
		}

		public function isMoreAppReady():Boolean
		{
			return plat.isMoreAppReady();
		}

		/*public function setBannerKeys(appID:String, key:String=null):void
		{
		}

		public function showBanner(adSize:AdSize, position:int):void
		{
		}

		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
		}

		public function hideBanner():void
		{
		}*/

		public function onAdHandler(e:Event):void
		{
//			trace("chartboost adapter event");
			this.dispatchEvent(new AdEvent(e.type,(e as  ChartboostEvent).data));
		}

		/*public function getBannerSize(type:int):AdSize
		{
			return new AdSize(320,50);
		}*/
	}
}
