package geb.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import mx.controls.Image;
	import mx.core.Container;

	public final class Util
	{
		public static function createBitmapDataFromImage(img:Image):BitmapData
		{
			var data:BitmapData=new BitmapData(img.width, img.height, true, 0x00000000);
			data.draw(img);
			return data;
		}
		
		public static function createBitmapData(img:DisplayObject):BitmapData
		{
			var data:BitmapData=new BitmapData(img.width, img.height, true, 0x00000000);
			data.draw(img);
			return data;
		}

		public static function showBitmapDataByImage(img:Image, data:BitmapData):void
		{
			clear(img);
			img.addChild(new Bitmap(data));
		}
		
		public static function clear(img:Image):void
		{
			var numChild:int=img.numChildren;
			while (img.numChildren >= 1)
			{
				img.removeChildAt(0)
			}
		}

		public static function createColorFromArgb(a:uint, r:uint, g:uint, b:uint):uint
		{
			a=a << 24;
			r=r << 16;
			g=g << 8;
			return a + r + g + b;
		}
		
		/**
		 * 创建数组并进行初始化
		 */
		public static function createByteArray(length: int, value:uint = 0):ByteArray
		{
			var array:ByteArray = new ByteArray();
			 
			for(var i:int = 0; i < length; i++)
			{
				array[i] = value;
			}
			
			return array;
		}
		
		public static function distanceSquear(x0:int, y0:int, x1:int, y1:int):int
		{
			var delX:int = x0 - x1;
			var delY:int = y0 - y1;
			return delX * delX + delY * delY;
		}
	}
}