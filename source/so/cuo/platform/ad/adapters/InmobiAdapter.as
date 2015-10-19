package so.cuo.platform.ad.adapters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.ad.AdSize;
	import so.cuo.platform.ad.IBanner;
	import so.cuo.platform.ad.IInterstitial;
	import so.cuo.platform.inmobi.Inmobi;
	import so.cuo.platform.inmobi.InmobiEvent;
	import so.cuo.platform.inmobi.InmobiSize;
	
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
	public class InmobiAdapter extends EventDispatcher implements  IBanner, IInterstitial
	{
		protected static const banners:Vector.<AdSize>=new Vector.<AdSize>();
		protected function get plat():Inmobi{
			return Inmobi.getInstance();
		}
		public function InmobiAdapter(appid:String)
		{
			plat.setBannerKeys(appid);
			plat.addEventListener(InmobiEvent.onBannerDismiss,onAdHandler);
			plat.addEventListener(InmobiEvent.onBannerFailedReceive,onAdHandler);
			plat.addEventListener(InmobiEvent.onBannerLeaveApplication,onAdHandler);
			plat.addEventListener(InmobiEvent.onBannerPresent,onAdHandler);
			plat.addEventListener(InmobiEvent.onBannerReceive,onAdHandler);
			
			plat.addEventListener(InmobiEvent.onInterstitialDismiss,onAdHandler);
			plat.addEventListener(InmobiEvent.onInterstitialFailedReceive,onAdHandler);
			plat.addEventListener(InmobiEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.addEventListener(InmobiEvent.onInterstitialPresent,onAdHandler);
			plat.addEventListener(InmobiEvent.onInterstitialReceive,onAdHandler);
			initBannerSize();
		}
		public function dispose():void
		{
			plat.removeEventListener(InmobiEvent.onBannerDismiss,onAdHandler);
			plat.removeEventListener(InmobiEvent.onBannerFailedReceive,onAdHandler);
			plat.removeEventListener(InmobiEvent.onBannerLeaveApplication,onAdHandler);
			plat.removeEventListener(InmobiEvent.onBannerPresent,onAdHandler);
			plat.removeEventListener(InmobiEvent.onBannerReceive,onAdHandler);
			
			plat.removeEventListener(InmobiEvent.onInterstitialDismiss,onAdHandler);
			plat.removeEventListener(InmobiEvent.onInterstitialFailedReceive,onAdHandler);
			plat.removeEventListener(InmobiEvent.onInterstitialLeaveApplication,onAdHandler);
			plat.removeEventListener(InmobiEvent.onInterstitialPresent,onAdHandler);
			plat.removeEventListener(InmobiEvent.onInterstitialReceive,onAdHandler);
			plat.dispose();
		}
		
		public function get supportDevice():Boolean
		{
			return plat.supportDevice;
		}

		public function get supportedBanner():Boolean
		{
			return true;
		}

		public function get supportedInterstitial():Boolean
		{
			return true;
		}

		public function setTesting(deviceID:String=null):void
		{
			plat.setTesting(deviceID);
		}
		/*public function setInterstitialKeys(appID:String, key:String=null):void
		{
			plat.setInterstitialKeys(appID,key);
		}*/
		/*public function setPlatform(key1:String, key2:String=""):void
		{
			plat.setBannerKeys(key1,key2);
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

		/*public function setBannerKeys(appID:String, key:String=null):void
		{
			plat.setBannerKeys(appID,key);
		}*/

		public function showBanner(adSize:AdSize, position:int):void
		{
			plat.showBanner(new  InmobiSize(adSize.width,adSize.height),position);
		}

		public function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void
		{
			plat.showBannerAbsolute(new  InmobiSize(adSize.width,adSize.height),x,y);
		}

		public function hideBanner():void
		{
			plat.hideBanner();
		}
		protected function initBannerSize():void
		{
			banners[AdSize.PHONE_PORTRAIT]=new AdSize(Inmobi.BANNER.width,Inmobi.BANNER.height);
			banners[AdSize.PHONE_LANDSCAPE]=new AdSize(Inmobi.IPAD_BANNER.width,Inmobi.IPAD_BANNER.height);
			banners[AdSize.PAD_PORTRAIT]=new AdSize(Inmobi.TABLE_LANDSCAPE.height,Inmobi.TABLE_LANDSCAPE.width);
			banners[AdSize.PAD_LANDSCAPE]=new AdSize(Inmobi.TABLE_LANDSCAPE.height,Inmobi.TABLE_LANDSCAPE.width);
			banners[AdSize.IAB_MRECT]=new AdSize(Inmobi.IAB_MRECT.width,Inmobi.IAB_MRECT.height);
		}
		public function getBannerSize(type:int):AdSize{
			if(type<banners.length&&type>=0){
				return banners[type];
			}
			return new AdSize(Inmobi.BANNER.width,Inmobi.BANNER.height);
		}
		
		public function onAdHandler(e:Event):void
		{
			var ae:InmobiEvent=e as  InmobiEvent;
			if(ae.data!=null&&(ae.data is   InmobiSize)){
				var size:InmobiSize=ae.data as  InmobiSize;
				this.dispatchEvent(new AdEvent(e.type,new AdSize(size.width,size.height)));
			}else{
				this.dispatchEvent(new AdEvent(e.type,(e as  InmobiEvent).data));
			}
		}
	}
}