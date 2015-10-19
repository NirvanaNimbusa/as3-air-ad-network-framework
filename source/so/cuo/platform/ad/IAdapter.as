package  so.cuo.platform.ad
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;

	public interface IAdapter extends IEventDispatcher
	{
		/**test this ane if  this device,pc and simulator aways return false,android and ios return true**/
//		function  setPlatform(key1:String,key2:String=null):void;
		function get supportDevice():Boolean;
		function setTesting(deviceID:String=null):void;
		/**ad event handler in ane**/
		function onAdHandler(e:Event):void;
		/**dispose this ane ,not use this instance any more**/
		function dispose():void;
	}
}
