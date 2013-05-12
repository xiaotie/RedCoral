package geb.events
{
	import flash.display.Bitmap;
	import flash.events.Event;

	public class BitmapEvent extends Event
	{
		public static const BITMAP_LOADED:String = "bitmapLoaded";
		
		public var bitmap:Bitmap;
		
		public var rotation:Number;
		
		public function BitmapEvent(bmp:Bitmap, type:String = BITMAP_LOADED)
		{
			super(type);
			this.bitmap = bmp;
		}
	}
}