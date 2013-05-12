package geb.image
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class BitmapDataEvent extends Event
	{
		public static const TypeName : String = "BitmapDataEvent";
		
		public var Data : BitmapData;
		
		public function BitmapDataEvent(data:BitmapData, type:String=TypeName)
		{
			super(type);
			Data = data;
		}
		
		public override function clone():Event
		{
			return new BitmapDataEvent(Data, this.type);
		} 
	}
}