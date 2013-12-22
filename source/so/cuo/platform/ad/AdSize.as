package   so.cuo.platform.ad
{

	public class AdSize
	{
		/**320,50**/
//		public static const BANNER:AdSize=new AdSize(320, 50);
		/**300,250**/
//		public static const IAB_MRECT:AdSize=new AdSize(300, 250);
		/**468,60**/
//		public static const IAB_BANNER:AdSize=new AdSize(468, 60);
		/**728,90**/
//		public static const IAB_LEADERBOARD:AdSize=new AdSize(728, 90);
		/**Smart Banners are new ad units (as of v6.0.0)
		 * that will render screen-wide banner ads
		 * on any screen size across different devices in either orientation.
		 *  Smart Banners help deal with increasing screen fragmentation
		 * across different devices by "smartly" detecting the width of the phone
		 * in its current orientation, and making the ad view that size. **/
//		public static const SMART_BANNER:AdSize=new AdSize(-1, -2);
		/**160,600**/
//		public static const IAB_WIDE_SKYSCRAPER:AdSize=new AdSize(160, 600);
		/**iPhones in Landscape 480,32**/
//		public static const IPHONE_LANDSCAPE:AdSize=new AdSize(480, 32);
		/**iPads in Portrait768,90**/
//		public static const IPAD_PORTRAIT:AdSize=new AdSize(769, 90);
		/**iPads in Landscape 1024,90**/
//		public static const IPAD_LANDSCAPE:AdSize=new AdSize(1024, 90);
		public static const PHONE_PORTRAIT:int=0;//AdSize(320, 50)
		public static const PHONE_LANDSCAPE:int=1;//AdSize(468, 60)
		public static const PAD_PORTRAIT:int=2;//new AdSize(769, 90)
		public static const PAD_LANDSCAPE:int=3;//new AdSize(728, 90)
		public static const IAB_MRECT:int=4;//AdSize(300, 250)
		protected var _width:int;
		protected var _height:int;

		/**you  can create a custom size ,for admob more ad size https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners**/
		public function AdSize(w:Number=320, h:Number=50)
		{
			this._width=w;
			this._height=h;
		}

		public function set height(value:int):void
		{
			_height=value;
		}

		public function set width(value:int):void
		{
			_width=value;
		}

		public function get width():int
		{
			return this._width;
		}

		public function get height():int
		{
			return this._height;
		}
		public function equals(adsize:AdSize):Boolean{
			if(adsize==null)return false;
			return adsize.width==this.width&&adsize.height==this.height;
		}
	}
}
