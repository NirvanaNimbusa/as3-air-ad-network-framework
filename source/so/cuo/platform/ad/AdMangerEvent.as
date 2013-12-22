package  so.cuo.platform.ad
{
	import flash.events.Event;
	
	public class AdMangerEvent extends Event
	{
		public static const onADEvent:String="onADEvent";
		public var platform:Object;
		public var eventType:String;
		public var eventData:*;
		public function AdMangerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}