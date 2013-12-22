package  so.cuo.platform.ad
{
	public class AdItem
	{
		public function AdItem(platform:IAdapter,rate:int=10,appKey:String="",signKey:String="",maxShowCount:int=-1)
		{
			this.platform=platform;
			this.appKey=appKey;
			this.rate=rate;
			this.signKey=signKey;
		}
		public var platform:IAdapter;
		public var rate:int;
		public var appKey:String;
		public var signKey:String;
		public var maxShowCount:int=-1;
		public var showCount:int=0;
	}
}