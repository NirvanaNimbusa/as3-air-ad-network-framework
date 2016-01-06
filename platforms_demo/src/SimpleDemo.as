package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import so.cuo.platform.ad.*;
	import so.cuo.platform.ad.adapters.*;

	public class SimpleDemo extends Sprite
	{
		public function SimpleDemo()
		{
			super();
			
			var list:Vector.<AdItem>=new Vector.<AdItem>();
			list.push(new AdItem(new BaiduAdapter("appid","bannerid","institialID","videoID"), 5,5));
			list.push(new AdItem(new AdmobAdapter("bannerid","institialID"), 10,5));
			AdManager.getInstance().configPlatforms(list);
			
			AdManager.getInstance().showBanner(AdSize.BANNER_STANDARD,AdPosition.BOTTOM_CENTER);
			AdManager.getInstance().showInterstitialOrCache();
			
			stage.addEventListener(MouseEvent.CLICK,click);
		}
		protected function click(event:MouseEvent):void
		{
			AdManager.getInstance().showInterstitialOrCache();
		}
	}
}