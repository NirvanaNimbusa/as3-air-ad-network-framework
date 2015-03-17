package  so.cuo.platform.ad
{
	public class AdItem
	{
		public function AdItem(platform:IAdapter,rate:int=10,_key1:String="",_key2:String="",maxShowCount:int=-1)
		{
			this.platform=platform;
			this.key1=_key1;
			this.key2=_key2;
			this.rate=rate;
		}
		public var platform:IAdapter;
		public var rate:int;
		public var key1:String;
		public var key2:String;
		public var maxShowCount:int=-1;
		public var showCount:int=0;
	}
}