package so.cuo.platform.ad
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class AdManager extends EventDispatcher
	{
		private static var inst:AdManager;
		protected var testingDeviceID:String="";
		protected var platforms:Vector.<AdItem>;
		protected var bannerPlatforms:Vector.<AdItem>=new Vector.<AdItem>();
		protected var interstitialPlatforms:Vector.<AdItem>=new Vector.<AdItem>();
		protected var morePagePlatforms:Vector.<AdItem>=new Vector.<AdItem>();
		protected var curBanner:IBanner;
		protected var curInterstitial:IInterstitial;
		protected var curMorePage:IMorePage;
		protected var totalBannerRate:int;
		protected var totalInstialRate:int;
		protected var totalMorePageRate:int;
		protected var autuCache:Boolean;
		protected var bannerState:BannerState=new BannerState();
		public var enableTrace:Boolean=true;
		
		protected var bannerFailTry:int=0;
		protected var interstitialFailTry:int=0;

		public static function getInstance():AdManager
		{
			if (inst == null)
			{
				inst=new AdManager();
			}
			return inst;
		}

		public function configPlatforms(config:Vector.<AdItem>, autoCache:Boolean=true):void
		{
			totalBannerRate=0;
			totalInstialRate=0;
			totalMorePageRate=0;
			bannerPlatforms.length=0;
			interstitialPlatforms.length=0;
			morePagePlatforms.length=0;
			this.platforms=config;
			this.autuCache=autoCache;
			for each (var item:AdItem in config)
			{
				var adapter:IAdapter=item.platform;
				if (adapter != null && adapter.supportDevice)
				{
					if (testingDeviceID != "")
						adapter.setTesting(this.testingDeviceID);
					if (adapter is IBanner)
					{
						var banner:IBanner=adapter as IBanner;
						if (banner.supportedBanner)
						{
							if (item.appKey != null)
							{
								banner.setBannerKeys(item.appKey, item.signKey);
							}
							totalBannerRate+=item.rate;
							bannerPlatforms.push(item);
							banner.addEventListener(AdEvent.onBannerFailedReceive, onAdEvent);
							banner.addEventListener(AdEvent.onBannerDismiss, onAdEvent);
							banner.addEventListener(AdEvent.onBannerLeaveApplication, onAdEvent);
							banner.addEventListener(AdEvent.onBannerPresent, onAdEvent);
							banner.addEventListener(AdEvent.onBannerReceive, onAdEvent);
						}
					}
					if (adapter is IInterstitial)
					{
						var interstitial:IInterstitial=adapter as IInterstitial;
						if (interstitial.supportedInterstitial)
						{
							if (item.appKey != null)
							{
								interstitial.setInterstitialKeys(item.appKey, item.signKey);
							}
							totalInstialRate+=item.rate;
							interstitialPlatforms.push(item);
							interstitial.addEventListener(AdEvent.onInterstitialFailedReceive, onAdEvent);
							interstitial.addEventListener(AdEvent.onInterstitialDismiss, onAdEvent);
							interstitial.addEventListener(AdEvent.onInterstitialLeaveApplication, onAdEvent);
							interstitial.addEventListener(AdEvent.onInterstitialPresent, onAdEvent);
							interstitial.addEventListener(AdEvent.onInterstitialReceive, onAdEvent);
						}
					}
					if (adapter is IMorePage)
					{
						var morePage:IMorePage=adapter as IMorePage;
						if (morePage.supportedMoreApp)
						{
							totalMorePageRate+=item.rate;
							morePagePlatforms.push(item);
						}
					}
				}
			}
		}

		public function cacheInterstitial():void
		{
			this.interstitialFailTry=0;
			this.docacheInterstitial();
		}
		public function docacheInterstitial():void
		{
			curInterstitial=nextPlatform(totalInstialRate, interstitialPlatforms) as IInterstitial;
			if (curInterstitial != null)
			{
				logTrace("AdManager.cacheInterstitial:" + curInterstitial);
				if (!curInterstitial.isInterstitialReady())
				{
					curInterstitial.cacheInterstitial();
				}
			}
		}

		public function cacheMoreApp():void
		{
			this.curMorePage=this.nextPlatform(totalMorePageRate, morePagePlatforms) as IMorePage;
			if (curMorePage != null)
			{
				curMorePage.cacheMoreApp();
			}
		}

		public function isInterstitialReady():Boolean
		{
			if (curInterstitial != null)
			{
				return curInterstitial.isInterstitialReady();
			}
			return false;
		}

		public function isMoreAppReady():Boolean
		{
			if (curMorePage != null)
			{
				return curMorePage.isMoreAppReady();
			}
			return false;
		}

		public function setTestingDevice(deviceID:String=null):void
		{
			this.testingDeviceID=deviceID;
		}

		public function hideBanner():void
		{
			if (curBanner != null)
			{
				curBanner.hideBanner();
			}
			bannerState.isBannerVisible=false;
		}

		public function showBanner(adSize:int, position:int):void
		{
			this.bannerFailTry=0;
			bannerState.isBannerVisible=true;
			bannerState.adSize=adSize;
			bannerState.relationPosition=position;
			bannerState.positionType=BannerState.RELATION;
			nextAdBanner();
		}

		public function showBannerAbsolute(adSize:int, x:Number, y:Number):void
		{
			this.bannerFailTry=0;
			bannerState.isBannerVisible=true;
			bannerState.adSize=adSize;
			bannerState.positionType=BannerState.ABS;
			bannerState.x=x;
			bannerState.y=y;
			nextAdBanner();
		}

		protected function nextAdBanner():void
		{
			if (!bannerState.isBannerVisible)
				return;
			var nextBanner:IAdapter=this.nextPlatform(totalBannerRate, bannerPlatforms);
			if (nextBanner == null)
				return;
//			if (nextBanner == curBanner)
//				return;
			if (curBanner != null&&nextBanner!=curBanner)
			{
				curBanner.hideBanner();
			}
			curBanner=nextBanner as IBanner;
			if (bannerState.positionType == BannerState.ABS)
			{
				curBanner.showBannerAbsolute(curBanner.getBannerSize(bannerState.adSize), bannerState.x, bannerState.y);
			}
			else
			{
				curBanner.showBanner(curBanner.getBannerSize(bannerState.adSize), bannerState.relationPosition);
			}
		}

		public function showInterstitial():void
		{
			if (curInterstitial != null)
			{
				curInterstitial.showInterstitial();
				updateShowCount();
			}
		}

		private function updateShowCount():void
		{
			var curItem:AdItem;
			var removed:Boolean=false;
			for (var i:int=0; i < interstitialPlatforms.length; i++)
			{
				curItem=interstitialPlatforms[i];
				if (curItem.platform == curInterstitial)
				{
					if ( curItem.maxShowCount > 0&& curItem.showCount>=curItem.maxShowCount)
					{
						interstitialPlatforms.splice(i, 1);
						logTrace(curItem.maxShowCount+"remove platform:"+curItem.platform+curItem.showCount);
					}
					removed=true;
					break;
				}
			}
			var rate:int=0;
			for each (var item:AdItem in interstitialPlatforms)
			{
				rate+=item.rate;
			}
			this.totalInstialRate=rate;
		}

		public function showInterstitialOrCache():void
		{
			this.interstitialFailTry=0;
			if (curInterstitial == null || !curInterstitial.isInterstitialReady())
			{
				this.docacheInterstitial();
			}
			else
			{
				this.showInterstitial();
			}
		}

		public function showMoreApp():void
		{
			if (curMorePage != null)
			{
				curMorePage.showMoreApp();
			}
		}

		protected function nextPlatform(totalRate:int, config:Vector.<AdItem>):IAdapter
		{
			if (config == null)
				return null;
			var sumRate:int=0;
			var randRate:int=Math.random() * totalRate;
			var item:AdItem;
			for (var i:int=0; i < config.length; i++)
			{
				item=config[i];
				sumRate+=item.rate;
				if (randRate <= sumRate)
				{
					logTrace("AdManager.nextPlatform platform:" + item.platform);
					return item.platform;
				}
			}
			return null;
		}

		public function dispose():void
		{
			if (platforms == null)
				return;
			for each (var item:AdItem in platforms)
			{
				var ad:IAdapter=item.platform;
				ad.removeEventListener(AdEvent.onBannerFailedReceive, onAdEvent);
				ad.removeEventListener(AdEvent.onBannerDismiss, onAdEvent);
				ad.removeEventListener(AdEvent.onBannerLeaveApplication, onAdEvent);
				ad.removeEventListener(AdEvent.onBannerPresent, onAdEvent);
				ad.removeEventListener(AdEvent.onBannerReceive, onAdEvent);
				ad.removeEventListener(AdEvent.onInterstitialFailedReceive, onAdEvent);
				ad.removeEventListener(AdEvent.onInterstitialDismiss, onAdEvent);
				ad.removeEventListener(AdEvent.onInterstitialLeaveApplication, onAdEvent);
				ad.removeEventListener(AdEvent.onInterstitialPresent, onAdEvent);
				ad.removeEventListener(AdEvent.onInterstitialReceive, onAdEvent);
				ad.dispose();
			}
			platforms.length=0;
			bannerPlatforms.length=0;
			interstitialPlatforms.length=0;
			morePagePlatforms.length=0;
		}

		private function onAdEvent(event:Event):void
		{
			logTrace("AdManager.onAdEvent: platform:" + event.currentTarget + " event:" + event.type);
			if (this.autuCache && event.type == AdEvent.onInterstitialDismiss || event.type == AdEvent.onInterstitialFailedReceive)
			{
				if(event.type==AdEvent.onInterstitialFailedReceive){
					interstitialFailTry++;
					if(interstitialFailTry<5){
						docacheInterstitial();
					}
				}else{
					this.docacheInterstitial();
				}
			}
			if (event.type == AdEvent.onBannerFailedReceive)
			{
				bannerFailTry++;
				if(bannerFailTry<5){
					this.nextAdBanner();
				}
			}
			if(event.type==AdEvent.onInterstitialReceive){
				interstitialFailTry=0;
			}
			if(event.type==AdEvent.onBannerReceive){
				bannerFailTry=0;
			}
			var e:AdMangerEvent=new AdMangerEvent(AdMangerEvent.onADEvent);
			e.eventType=event.type;
			e.eventData=(event as Object).data;
			e.platform=event.currentTarget;
			this.dispatchEvent(e);
		}

		private function logTrace(msg:String):void
		{
			if (enableTrace)
				trace(msg);
		}
	}
}

class BannerState
{
	public static const RELATION:int=0;
	public static const ABS:int=1;
	public var isBannerVisible:Boolean=false;
	public var positionType:int=RELATION; //
	public var adSize:int;
	public var x:int;
	public var y:int;
	public var relationPosition:int;
}
