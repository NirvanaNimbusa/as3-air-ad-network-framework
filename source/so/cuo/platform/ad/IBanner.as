package so.cuo.platform.ad
{
	public interface IBanner extends IAdapter
	{
		//banner
		/**set banner key ,for admob appID need,for chartboost appid and sign need**/
		function setBannerKeys(appID:String,key:String=null):void;
		/**show banner relation ,position value in AdPosition
		 * showBanner(new Adsize(320,50),AdPosition.BOTTOM_CENTER);
		 * **/
		function showBanner(adSize:AdSize, position:int):void;
		/**
		 * show banner absolute
		 * showBannerAbsolute(new Adsize(468,60),0,0);
		 * **/
		function showBannerAbsolute(adSize:AdSize, x:Number, y:Number):void;
		/**hide banner ad**/
		function hideBanner():void;
		
		function getBannerSize(type:int):AdSize;
		
		/**test this ane support banner ad,admob support ,chartboost not support**/
		function get supportedBanner():Boolean;
	}
}