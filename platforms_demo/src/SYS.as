package 
{
    import flash.system.Capabilities;
	//replace all fake ID with your really ID before run
    public class SYS
    {
		//www.chartboost.com 
		public static var chartboostAppId:String=" chartboost appid "; 
		public static var appSignature:String=" chartboost signkey ";
		
		//www.inmobi.com
		public static function getInmobiAppID():String{
			return isIOS?" inmobi appid  for ios":" inmobi appid for android";
		}
		
		//www.admob.com
		public static function get admobBannerID():String{
			return isIOS?"admob ios banner id":"admob  android banner id ";
		}
		public static function get admobInterstitialID():String{
			return isIOS?"admob ios Interstitial id":"admob  android Interstitial id ";//replace this fake ID with your really ID
		}
		//http://munion.baidu.com/
		public static function get baiduAPPSEC():String{
			return isIOS?"debug":"debug";
		}
		public static function get baiduAPPSID():String{
			return isIOS?"debug":"debug";
		}
		
		//
		public static function get isIOS():Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") != -1;
		}		
    }
}