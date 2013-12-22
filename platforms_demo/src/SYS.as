package 
{
    import flash.system.Capabilities;

    public class SYS
    {
		public static var admobID:String="a152a806cf2f09b";;//"a152834c8723912";//"a152a806cf2f09b";//"a14fefc5c8ab372";a152af025a3526b
		public static var chartboostAppId:String="51bdcf7616ba475450000005"; 
		public static var appSignature:String="28c18ae143999b71468de4a7b50eff51ce83fac0";
		public static function getInmobiAppID():String{
			return isIOS?"75105241eb4b41bf85ce6d956c1fe265":"56a2016932af4b71920ca22e2349e937";
		}
		public static function get admobBannerID():String{
			return isIOS?"a152a806cf2f09b":"a15151168ba8c01";
		}
		public static function get isIOS():Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") != -1;
		}
		
    }
}