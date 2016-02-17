package  so.cuo.platform.ad
{
	import flash.events.Event;
	/**
	 * ad event 
	 * ref  https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
	 **/
	public class AdEvent extends Event
	{
		/**
		 * Event which will be fired when  ad is clicked  and not leave app. will show a full screen in app ad
		 */
		public static const onBannerDismiss:String = "onBannerDismiss";
		/**
		 *Event which will be fired when fail to receive ad
		 **/
		public static const onBannerFailedReceive:String = "onBannerFailedReceive";
		/**
		 * Event which will be fired when ad clicked and will leave app.
		 */
		public static const onBannerLeaveApplication:String = "onBannerLeaveApplication";
		/**
		 * Event which will be fired when ad will been add to screen.
		 */
		public static const onBannerPresent:String = "onBannerPresent";
		/**
		 * Event which will be fired when ad received success 
		 */
		public static const onBannerReceive:String = "onBannerReceive";
		
		
		/**
		 * Event which will be fired when  ad is clicked  and not leave app. will show a full screen in app ad
		 */
		public static const onInterstitialDismiss:String = "onInterstitialDismiss";
		/**
		 *Event which will be fired when fail to receive ad
		 **/
		public static const onInterstitialFailedReceive:String = "onInterstitialFailedReceive";
		/**
		 * Event which will be fired when ad clicked and will leave app.
		 */
		public static const onInterstitialLeaveApplication:String = "onInterstitialLeaveApplication";
		/**
		 * Event which will be fired when ad will been add to screen.
		 */
		public static const onInterstitialPresent:String = "onInterstitialPresent";
		/**
		 * Event which will be fired when ad received success 
		 */
		public static const onInterstitialReceive:String = "onInterstitialReceive";
		
		public static const onMoreAppDismiss:String = "onMoreAppDismiss";
		public static const onMoreAppFailedReceive:String = "onMoreAppFailedReceive";
		public static const onMoreAppLeaveApplication :String= "onMoreAppLeaveApplication";
		public static const onMoreAppPresent :String= "onMoreAppPresent";
		public static const onMoreAppReceive:String = "onMoreAppReceive";
		
		public var data:Object;
		public var platform:Object;
		public function AdEvent(type:String,data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}
