package geb.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.utils.ByteArray;

	// from: http://blog.yoz.sk/2009/10/bitmap-bitmapdata-bytearray/
	public class BitmapHelper
	{
		public static function loadByteArray2BitmapData(bytes:ByteArray, callback:Function):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(
				Event.COMPLETE,
				function(event:Event):void
				{
					var loaderInfo:LoaderInfo = LoaderInfo(event.target);    
					var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, true, 0x00000000);   
					bitmapData.draw(loaderInfo.loader);
					callback(bitmapData);
				});
			loader.loadBytes(bytes);
		}
		
		public static function loadByteArray2Bitmap(bytes:ByteArray, callback:Function, smoothing:Boolean = false):void
		{
			loadByteArray2BitmapData(bytes,
				function(bmpData:BitmapData):void
				{
					var bmp:Bitmap = new Bitmap(bmpData,"auto",smoothing);
					callback(bmp);
				});
		}
	}
}