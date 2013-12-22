package so.cuo.platform.ad
{
	public interface IInterstitial extends IAdapter
	{
		//interstitial
		/**set interstitial keys ,for admob ,just appID need ,chartboost need appid and sign**/
		function setInterstitialKeys(appID:String,key:String=null):void;
		/**cache interstitial ,call this before showInterstial**/
		function cacheInterstitial():void;
		/**show interstitial ,call this after isInterstitialReady true
		 * if(admob.isInterstitialReady()){
		 * 		admob.showInterstitial();
		 * }
		 * **/
		function showInterstitial():void;
		/**
		 * test if Interstitial has ready,if cache success this will be true 
		 * **/
		function isInterstitialReady():Boolean;
		
		/**test this ane support interstitial chartboost ,admob support**/
		function get supportedInterstitial():Boolean;
		/**set testing mode ,if you are testing pass deviceID for admob ,deviceID is a udid of device,app run on store not call this method or pass null**/
	}
}