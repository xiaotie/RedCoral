package geb.image
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * 灰度图像
	 */
	public class GrayscaleImage extends ImageChannel
	{
		public function GrayscaleImage(width:int, height:int)
		{
			super(width, height);
		}
		
		public static function CreateFromArgbImage(argb:ArgbImage2):GrayscaleImage
		{
			var img:GrayscaleImage = new GrayscaleImage(argb.Width, argb.Height);
			var a : ByteArray = argb.A.Data;
			var r : ByteArray = argb.R.Data;
			var g : ByteArray = argb.G.Data;
			var b : ByteArray = argb.B.Data;
			
			var myData:ByteArray = img.Data;
			
			for(var i : int = 0; i < myData.length; i++)
			{
				myData[i] = 0.3 * r[i] + 0.59 * g[i] + 0.11 * b[i];
			}
			
			return img;
		}
		
		/**
		 * 转换为 BitmapData 图像
		 * @transparent 图像是否透明
		 * @transparentGray 将透明像素所对应的灰度值
		 * @tolerance 透明灰度的容差。具备transparentGray 正负 tolerance 之间（含）的灰度的像素视为透明像素
		 */
		public function ToBitmapData(transparent:Boolean = false, transparentGray : uint = 255, tolerance : uint = 1 ):BitmapData
		{
			var transGrayUpper : int = transparentGray + tolerance;
			var transGrayLower : int = transparentGray - tolerance;
			
			var data : BitmapData = new BitmapData(this.Width, this.Height);
			for(var h : int = 0; h < this.Height; h++)
			{
				for(var w : int = 0; w < this.Width; w++)
				{
					var index : int = h * this.Width + w;
					var gray : int = this.Data[index];
					var color : uint = gray << 16 + gray << 8 + gray;
					if(transparent == false)
					{
						data.setPixel(w,h,0xFF000000 + color);
					}
					else
					{
						if(gray < transGrayLower || gray > transGrayUpper)
						{
							data.setPixel(w,h,0xFF000000 + color);
						}
						else
						{
							data.setPixel(w,h,color);
						}
					}
				}
			}
			return data;
		}
	}
}