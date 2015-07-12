package so.cuo.platform.ad.adapters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.AdMangerEvent;
	import so.cuo.platform.ad.AdSize;
	import so.cuo.platform.ad.IAdapter;
	import so.cuo.platform.ad.IBanner;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	import so.cuo.platform.admob.AdmobSize;
	
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
	public class AdmobAdapter extends EventDispatcher implements  IBanner, IInterstitial
	{
		protected static const banners:Vector.<AdSize>=new Vector.<AdSize>();
		private var bannerKey:String;
		private var instKey:String;
		protected function get plat():Admob{
			return Admob.getInstance();
		}
		public function AdmobAdapter()
		{
			plat.addEventListener(AdmobEvent.onBannerDismiss,onAdHandler);
			plat.addEventListener(AdmobEvent.onBannerFailedReceive,onAdHandler);
			plat.addEventListener(AdmobEvent.onBannerLeaveApplication,onAdHandler);
			plat.addEventListener(AdmobEvent.onBannerPresent,onAdHandler);
			plat.addEventListener(AdmobEvent.onBannerReceive,onAdHandler);
			
			plat.addEventListener(AdmobEvent.onInterstitialDismiss,onAdHandler);
			plat.addEventListener(AdmobEvent.onInterstitialFailedReceive,onAdHandler);
			plat.addEventListener(AdmobEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.addEventListener(AdmobEvent.onInterstitialPresent,onAdHandler);
			plat.addEventListener(AdmobEvent.onInterstitialReceive,onAdHandler);
			initBannerSize();
		}
		
		public function dispose():void
		{
			plat.removeEventListener(AdmobEvent.onBannerDismiss,onAdHandler);
			plat.removeEventListener(AdmobEvent.onBannerFailedReceive,onAdHandler);
			plat.removeEventListener(AdmobEvent.onBannerLeaveApplication,onAdHandler);
			plat.removeEventListener(AdmobEvent.onBannerPresent,onAdHandler);
			plat.removeEventListener(AdmobEvent.onBannerReceive,onAdHandler);
			
			plat.removeEventListener(AdmobEvent.onInterstitialDismiss,onAdHandler);
			plat.removeEventListener(AdmobEvent.onInterstitialFailedReceive,onAdHandler);
			plat.removeEventListener(AdmobEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.removeEventListener(AdmobEvent.onInterstitialPresent,onAdHandler);
			plat.removeEventListener(AdmobEvent.onInterstitialReceive,onAdHandler);
			plat.dispose();
		}

		public function get supportDevice():Boolean
		{
			return plat.supportDevice;
		}

		public function get supportedBanner():Boolean
		{
			return plat.supportDevice;
		}

		public function get supportedInterstitial():Boolean
		{
			return plat.supportDevice;
		}

		public function setTesting(deviceID:String=null):void
		{
//			plat.setTesting(deviceID);
		}
/*		public function setInterstitialKeys(appID:String, key:String=null):void
		{
			if(appID==null)return;
			if(bannerKey==null){
				bannerKey=appID;
			}
			instKey=appID;
			plat.setKeys(bannerKey,instKey);
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

		public function setPlatform(key1:String, key2:String=""):void
		{
			bannerKey=key1;
			instKey=key2;
			plat.setKeys(bannerKey,instKey);
		}

		public function showBanner(adSize:AdSize, position:int):void
		{
			plat.showBanner(new AdmobSize(adSize.width,adSize.height),position);
		}

		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
			plat.showBannerAbsolute(new AdmobSize(adSize.width,adSize.height),x,y);
		}

		public function hideBanner():void
		{
			plat.hideBanner();
		}
		protected function initBannerSize():void
		{
			banners[AdSize.PHONE_PORTRAIT]=new AdSize(Admob.BANNER.width,Admob.BANNER.height);
			banners[AdSize.PHONE_LANDSCAPE]=new AdSize(Admob.IAB_BANNER.width,Admob.IAB_BANNER.height);
			banners[AdSize.PAD_PORTRAIT]=new AdSize(Admob.IPAD_PORTRAIT.width,Admob.IPAD_PORTRAIT.height);
			banners[AdSize.PAD_LANDSCAPE]=new AdSize(Admob.IPAD_LANDSCAPE.width,Admob.IPAD_LANDSCAPE.height);
			banners[AdSize.IAB_MRECT]=new AdSize(Admob.IAB_MRECT.width,Admob.IAB_MRECT.height);
			banners[AdSize.SMART_BANNER]=new AdSize(Admob.SMART_BANNER.width,Admob.SMART_BANNER.height);
		}
		public function getBannerSize(type:int):AdSize{
			if(type<banners.length&&type>=0){
				return banners[type];
			}
			return new AdSize(Admob.BANNER.width,Admob.BANNER.height);
		}
		public function onAdHandler(e:Event):void
		{
			var ae:AdmobEvent=e as AdmobEvent;
			if(ae.data!=null&&(ae.data is AdmobSize)){
				var size:AdmobSize=ae.data as AdmobSize;
				this.dispatchEvent(new AdEvent(e.type,new AdSize(size.width,size.height)));
			}else{
				this.dispatchEvent(new AdEvent(e.type,(e as AdmobEvent).data));
			}
		}
	}
}