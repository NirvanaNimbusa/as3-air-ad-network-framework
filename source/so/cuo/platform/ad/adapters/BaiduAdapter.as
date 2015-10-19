package so.cuo.platform.ad.adapters
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.AdSize;
	import so.cuo.platform.ad.IBanner;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.baidu.*;

	[Event(name="onBannerDismiss", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onBannerFailedReceive", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onBannerLeaveApplication", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onBannerPresent", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onBannerReceive", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialDismiss", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialFailedReceive", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialLeaveApplication", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialPresent", type="so.cuo.platform.ad.AdEvent")]
	[Event(name="onInterstitialReceive", type="so.cuo.platform.ad.AdEvent")]
	public class BaiduAdapter extends EventDispatcher implements  IBanner, IInterstitial
	{
		protected static const banners:Vector.<AdSize>=new Vector.<AdSize>();
//		protected var key:String;
		protected function get plat():BaiDu{
			return BaiDu.getInstance();
		}
		public function BaiduAdapter(appid:String,bannerID:String,institialID:String,videoID:String)
		{
			plat.setKeys(appid,bannerID,institialID,videoID);
			plat.addEventListener(BaiDuAdEvent.onBannerDismiss,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onBannerFailedReceive,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onBannerLeaveApplication,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onBannerPresent,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onBannerReceive,onAdHandler);
			
			plat.addEventListener(BaiDuAdEvent.onInterstitialDismiss,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onInterstitialFailedReceive,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onInterstitialPresent,onAdHandler);
			plat.addEventListener(BaiDuAdEvent.onInterstitialReceive,onAdHandler);
			initBannerSize();
		}
		protected function initBannerSize():void
		{
			banners[AdSize.PHONE_PORTRAIT]=new AdSize(BaiDu.BANNER.width,BaiDu.BANNER.height);
			banners[AdSize.PHONE_LANDSCAPE]=new AdSize(BaiDu.IAB_BANNER.width,BaiDu.IAB_BANNER.height);
			banners[AdSize.PAD_PORTRAIT]=new AdSize(BaiDu.IAB_LEADERBOARD.width,BaiDu.IAB_LEADERBOARD.height);
			banners[AdSize.PAD_LANDSCAPE]=new AdSize(BaiDu.IAB_LEADERBOARD.width,BaiDu.IAB_LEADERBOARD.height);
			banners[AdSize.IAB_MRECT]=new AdSize(BaiDu.IAB_MRECT.width,BaiDu.IAB_MRECT.height);
		}
		
		public function get supportDevice():Boolean
		{
			return plat.supportDevice;
		}
		
		public function setTesting(deviceID:String=null):void
		{
		}
		
		public function onAdHandler(e:Event):void
		{
			var ae:BaiDuAdEvent=e as BaiDuAdEvent;
			if(ae.data!=null&&(ae.data is BaiDuSize)){
				var size:BaiDuSize=ae.data as  BaiDuSize;
				this.dispatchEvent(new AdEvent(e.type,new AdSize(size.width,size.height)));
			}else{
				this.dispatchEvent(new AdEvent(e.type,(e as BaiDuAdEvent).data));
			}
		}
		
		public function dispose():void
		{
			plat.removeEventListener(BaiDuAdEvent.onBannerDismiss,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onBannerFailedReceive,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onBannerLeaveApplication,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onBannerPresent,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onBannerReceive,onAdHandler);
			
			plat.removeEventListener(BaiDuAdEvent.onInterstitialDismiss,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onInterstitialFailedReceive,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onInterstitialPresent,onAdHandler);
			plat.removeEventListener(BaiDuAdEvent.onInterstitialReceive,onAdHandler);
		}
/*		public function setPlatform(key1:String, key2:String=""):void
		{
//			bannerKey=key1;
//			instKey=key2;
//			plat.setKeys(bannerKey,instKey);
			plat.setKeys(key1,key2);
		}*/
		/*public function setInterstitialKeys(appID:String, key:String=null):void
		{
			plat.setKeys(appID,key);
		}*/

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

		public function get supportedInterstitial():Boolean
		{
			return true;
		}

		/*public function setBannerKeys(appID:String, key:String=null):void
		{
			plat.setKeys(appID,key);
		}*/

		public function showBanner(adSize:AdSize, position:int):void
		{
			plat.showBanner(new BaiDuSize(adSize.width,adSize.height),position);
		}

		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
			plat.showBannerAbsolute(new BaiDuSize(adSize.width,adSize.height),x,y);
		}

		public function hideBanner():void
		{
			plat.hideBanner();
		}

		public function getBannerSize(type:int):AdSize
		{
			if(type<banners.length&&type>=0){
				return banners[type];
			}
			return new AdSize(BaiDu.BANNER.width,BaiDu.BANNER.height);
		}

		public function get supportedBanner():Boolean
		{
			return true;
		}
	}
}