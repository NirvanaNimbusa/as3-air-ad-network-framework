package so.cuo.platform.ad
{
	public interface IMorePage extends IAdapter
	{
		//more app page
		/**set more app key,chartboost need**/
//		function setMoreAppKeys(appID:String,key:String=null):void;
		/**cache more app page,call this before showMoreApp**/
		function cacheMoreApp():void;
		/**show more app page 
		 * if(iad.isMoreAppReady){
		 * showMoreApp();
		 * }
		 * **/
		function showMoreApp():void;
		/**test more app is ready,if cache success return true**/
		function isMoreAppReady():Boolean;
		
		/**test this ane support more app ,chartboost support ,admob not support**/
		function get supportedMoreApp():Boolean;
	}
}