package so.cuo.platform.ad.adapters
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.AdSize;
	import so.cuo.platform.ad.IBanner;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.ad.IMorePage;
	import so.cuo.platform.gdt.GDTAds;
	import so.cuo.platform.gdt.GDTEvent;
	import so.cuo.platform.gdt.GDTSize;

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
	public class GDTAdapter extends EventDispatcher implements  IBanner, IInterstitial,IMorePage
	{
		protected static const banners:Vector.<AdSize>=new Vector.<AdSize>();
		private var appWallKey:String;
		protected function get plat():GDTAds{
			return GDTAds.getInstance();
		}
		public function GDTAdapter(appid:String,bannerID:String,institialID:String,appWall:String,splashID:String="")
		{
			appWallKey=appWall;
			plat.setKeys(appid,bannerID,institialID,splashID);
			plat.addEventListener(GDTEvent.onBannerDismiss,onAdHandler);
			plat.addEventListener(GDTEvent.onBannerFailedReceive,onAdHandler);
			plat.addEventListener(GDTEvent.onBannerLeaveApplication,onAdHandler);
			plat.addEventListener(GDTEvent.onBannerPresent,onAdHandler);
			plat.addEventListener(GDTEvent.onBannerReceive,onAdHandler);
			
			plat.addEventListener(GDTEvent.onInterstitialDismiss,onAdHandler);
			plat.addEventListener(GDTEvent.onInterstitialFailedReceive,onAdHandler);
			plat.addEventListener(GDTEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.addEventListener(GDTEvent.onInterstitialPresent,onAdHandler);
			plat.addEventListener(GDTEvent.onInterstitialReceive,onAdHandler);
			initBannerSize();
		}
		protected function initBannerSize():void
		{
			banners[AdSize.PHONE_PORTRAIT]=new AdSize(GDTAds.BANNER.width,GDTAds.BANNER.height);
			banners[AdSize.PHONE_LANDSCAPE]=new AdSize(GDTAds.BANNER_468x60.width,GDTAds.BANNER_468x60.height);
			banners[AdSize.PAD_PORTRAIT]=new AdSize(GDTAds.BANNER_728x90.width,GDTAds.BANNER_728x90.height);
			banners[AdSize.PAD_LANDSCAPE]=new AdSize(GDTAds.BANNER_728x90.width,GDTAds.BANNER_728x90.height);
			banners[AdSize.IAB_MRECT]=new AdSize(GDTAds.ANDROID_BANNER_220X120.width,GDTAds.ANDROID_BANNER_220X120.height);
			banners[AdSize.SMART_BANNER]=new AdSize(GDTAds.ANDROID_SMART_BANNER.width,GDTAds.ANDROID_SMART_BANNER.height);
			banners[AdSize.BANNER_STANDARD]=new AdSize(GDTAds.BANNER.width,GDTAds.BANNER.height);
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
			var ae:GDTEvent=e as GDTEvent;
			if(ae.data!=null&&(ae.data is GDTSize)){
				var size:GDTSize=ae.data as  GDTSize;
				this.dispatchEvent(new AdEvent(e.type,new AdSize(size.width,size.height)));
			}else{
				this.dispatchEvent(new AdEvent(e.type,(e as GDTEvent).data));
			}
		}
		
		public function dispose():void
		{
			plat.removeEventListener(GDTEvent.onBannerDismiss,onAdHandler);
			plat.removeEventListener(GDTEvent.onBannerFailedReceive,onAdHandler);
			plat.removeEventListener(GDTEvent.onBannerLeaveApplication,onAdHandler);
			plat.removeEventListener(GDTEvent.onBannerPresent,onAdHandler);
			plat.removeEventListener(GDTEvent.onBannerReceive,onAdHandler);
			
			plat.removeEventListener(GDTEvent.onInterstitialDismiss,onAdHandler);
			plat.removeEventListener(GDTEvent.onInterstitialFailedReceive,onAdHandler);
			plat.removeEventListener(GDTEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.removeEventListener(GDTEvent.onInterstitialPresent,onAdHandler);
			plat.removeEventListener(GDTEvent.onInterstitialReceive,onAdHandler);
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

		public function get supportedInterstitial():Boolean
		{
			return true;
		}

		public function showBanner(adSize:AdSize, position:int):void
		{
			plat.showBanner(new GDTSize(adSize.width,adSize.height),position);
		}

		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
			plat.showBannerAbsolute(new GDTSize(adSize.width,adSize.height),x,y);
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
			return new AdSize(GDTAds.BANNER.width,GDTAds.BANNER.height);
		}

		public function get supportedBanner():Boolean
		{
			return GDTAds.getInstance().supportDevice;
		}
		
		public function cacheMoreApp():void
		{
		}
		
		public function isMoreAppReady():Boolean
		{
			return true;
		}
		
		public function showMoreApp():void
		{
			GDTAds.getInstance().showMoreApp(appWallKey);
			
		}
		
		public function get supportedMoreApp():Boolean
		{
			if(Capabilities.manufacturer.indexOf('Android') > -1)return true;
			return false;
		}
		
	}
}