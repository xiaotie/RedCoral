package geb.image
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class ArgbImage
	{
		public var width:int;
		public var height:int;
		public var data:ByteArray;
		
		public function ArgbImage(width:int, height:int)
		{
			this.width=width;
			this.height=height;
			data= Util.createByteArray(width*height*4);
		}
		
		public static function createFromBitmapData(data:BitmapData):ArgbImage
		{
			var width:int=data.width;
			var height:int=data.height;
			var img:ArgbImage=new ArgbImage(data.width, data.height);
			var i:int=0;
			var c:uint=0;
			var dst:ByteArray = img.data;
			for (var w : int =0; w < width; w++)
			{
				for (var h : int =0; h < height; h++)
				{
					i=h * width + w;
					c=data.getPixel32(w, h);
					dst[i]=(c >> 24) & 0xFF;
					dst[i+1]=(c >> 16) & 0xFF;
					dst[i+2]=(c >> 8) & 0xFF;
					dst[i+3]=c & 0xFF;
				}
			}
			return img;
		}
		
		public function toBitmapData():BitmapData
		{
			var bmpData:BitmapData=new BitmapData(this.width, this.height);
			var i:int=0;
			
			for (var w:int=0; w < this.width; w++)
			{
				for (var h:int=0; h < this.height; h++)
				{
					i=h * this.width + w;
					
					if(data[i]!=0)
					{
						bmpData.setPixel32(w,h,Util.createColorFromArgb(data[i],data[i+1],data[i+2],data[i+3]));
					}
					else
					{
						bmpData.setPixel32(w, h, 0);
					}
				}
			}
			return bmpData;
		}
		
		/**
		 *   Y=( X - 127 ) * A + B + 127 => Y = X * A - 127 * A + 127＋B (1)
		   * 　　令：B = B -127 * A ＋127 (2)
		   * 　    由上面(1),(2)两步，得到一个新的公式：Y = X * A + B
		 */
		// public function adjustBrightnessAndContrast(var 
	}
}