package so.cuo.platform.ad.adapters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.AdSize;
	import so.cuo.platform.ad.IBanner;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.iad.IAd;
	import so.cuo.platform.iad.IAdEvent;
	import so.cuo.platform.iad.IAdSize;

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
	public class IAdAdapter extends EventDispatcher implements  IBanner,IInterstitial
	{
		protected static const banners:Vector.<AdSize>=new Vector.<AdSize>();
		protected function get plat():IAd{
			return IAd.getInstance();
		}
		public function IAdAdapter()
		{
			var plat:IAd=IAd.getInstance();
			plat.addEventListener(IAdEvent.onBannerDismiss,onAdHandler);
			plat.addEventListener(IAdEvent.onBannerFailedReceive,onAdHandler);
			plat.addEventListener(IAdEvent.onBannerLeaveApplication,onAdHandler);
			plat.addEventListener(IAdEvent.onBannerPresent,onAdHandler);
			plat.addEventListener(IAdEvent.onBannerReceive,onAdHandler);
			
			plat.addEventListener(IAdEvent.onInterstitialDismiss,onAdHandler);
			plat.addEventListener(IAdEvent.onInterstitialFailedReceive,onAdHandler);
			plat.addEventListener(IAdEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.addEventListener(IAdEvent.onInterstitialPresent,onAdHandler);
			plat.addEventListener(IAdEvent.onInterstitialReceive,onAdHandler);
			this.initBannerSize();
		}
		public function dispose():void
		{
			plat.removeEventListener(IAdEvent.onBannerDismiss,onAdHandler);
			plat.removeEventListener(IAdEvent.onBannerFailedReceive,onAdHandler);
			plat.removeEventListener(IAdEvent.onBannerLeaveApplication,onAdHandler);
			plat.removeEventListener(IAdEvent.onBannerPresent,onAdHandler);
			plat.removeEventListener(IAdEvent.onBannerReceive,onAdHandler);
			
			plat.removeEventListener(IAdEvent.onInterstitialDismiss,onAdHandler);
			plat.removeEventListener(IAdEvent.onInterstitialFailedReceive,onAdHandler);
			plat.removeEventListener(IAdEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.removeEventListener(IAdEvent.onInterstitialPresent,onAdHandler);
			plat.removeEventListener(IAdEvent.onInterstitialReceive,onAdHandler);
			plat.dispose();
		}
		public function cacheInterstitial():void
		{
			plat.cacheInterstitial();
		}
		
		public function getBannerSize(type:int):AdSize
		{
			if(type<banners.length&&type>=0){
				return banners[type];
			}
			return new AdSize(IAd.BANNER.width,IAd.BANNER.height);
		}
		
		public function hideBanner():void
		{
			plat.hideBanner();
		}
		
		public function isInterstitialReady():Boolean
		{
			return plat.isInterstitialReady();
		}
		
		public function onAdHandler(e:Event):void
		{
			var ae:IAdEvent=e as  IAdEvent;
			if(ae.data!=null&&(ae.data is  IAdSize)){
				var size:IAdSize=ae.data as  IAdSize;
				this.dispatchEvent(new  AdEvent(e.type,new AdSize(size.width,size.height)));
			}else{
				this.dispatchEvent(new AdEvent(e.type,(e as   IAdEvent).data));
			}
		}
		
		/*public function setBannerKeys(appID:String, key:String=null):void
		{
		}
		
		public function setInterstitialKeys(appID:String, key:String=null):void
		{
		}*/
	/*	public function setPlatform(key1:String, key2:String=""):void
		{
		}*/
		public function setTesting(deviceID:String=null):void
		{
		}
		
		public function showBanner(adSize:AdSize, position:int):void
		{
			plat.showBanner(new IAdSize(adSize.width,adSize.height),position);
		}
		
		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
			plat.showBannerAbsolute(new IAdSize(adSize.width,adSize.height),x,y);
		}
		
		public function showInterstitial():void
		{
			plat.showInterstitial();
		}
		
		public function get supportDevice():Boolean
		{
			return plat.supportDevice;
		}
		
		public function get supportedBanner():Boolean
		{
			return plat.supportedBanner;
		}
		
		public function get supportedInterstitial():Boolean
		{
			return plat.supportedInterstitial;
		}
		
		protected function initBannerSize():void
		{
			banners[AdSize.PHONE_PORTRAIT]=new AdSize(IAd.BANNER.width,IAd.BANNER.height);
			banners[AdSize.PHONE_LANDSCAPE]=new AdSize(IAd.BANNER.width,IAd.BANNER.height);
			banners[AdSize.PAD_PORTRAIT]=new AdSize(IAd.BANNER.width,IAd.BANNER.height);
			banners[AdSize.PAD_LANDSCAPE]=new AdSize(IAd.BANNER.width,IAd.BANNER.height);
			banners[AdSize.IAB_MRECT]=new AdSize(IAd.IAB_MRECT.width,IAd.IAB_MRECT.height);
		}
	}
}