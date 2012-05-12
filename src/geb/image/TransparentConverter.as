package geb.image
{
	import flash.display.BitmapData;

	/**
	 * 图像透明化工具
	 */
	public class TransparentConverter
	{
		public var GrayTransMin:Number;		// 最小灰度	
		public var GrayTransMax:Number;		// 最大灰度
		public var XMaskShift:Number;
		public var YMaskShift:Number;
		public var MaskRadius:Number;

		public var ClearMode:Boolean=false;

		public function TransparentConverter(grayTransMin:Number=0.0, grayTransMax:Number=255.0)
		{
			this.GrayTransMin=grayTransMin;
			this.GrayTransMax=grayTransMax;
		}

		public function HandleBitmapData(srcmap:BitmapData, map:BitmapData):BitmapData
		{
			if (srcmap == null || map == null)
				return null;

			var dst:BitmapData=srcmap.clone();

			var minGray:Number=this.GrayTransMin;
			var maxGray:Number=this.GrayTransMax;
			var maxDistance:Number=MaskRadius * MaskRadius;

			for (var x:int=0; x < map.width; x++)
			{
				for (var y:int=0; y < map.height; y++)
				{
					var xShift:Number=XMaskShift - x;
					var yShift:Number=YMaskShift - y;
					var distance:Number=xShift * xShift + yShift * yShift;
					var src:uint=srcmap.getPixel32(x, y);
					if (distance < maxDistance)
					{
						if (ClearMode == true)
						{
							map.setPixel32(x, y, 0xFFCCCC00); // Clear
						}
						else
						{
							map.setPixel32(x, y, 0xFFCCCCCC); // declear
						}
					}

					var mask:uint=map.getPixel32(x, y);
					if (mask == 0xFFCCCC00)
					{
						src=src && 0x00FFFFFF;
						dst.setPixel32(x, y, src);
					}
					else if (mask == 0xFFCCCCCC)
					{
						dst.setPixel32(x, y, src);
					}
					else
					{
						var r:uint=src >> 16 & 0xFF;
						var g:uint=src >> 8 & 0xFF;
						var b:uint=src & 0xFF;
						var alpha:uint=src >> 24 & 0xFF;
						var gray:Number=0.299 * r + 0.587 * g + 0.114 * b;
						if (gray < minGray || gray > maxGray)
						{
							src=src && 0x00FFFFFF;
							dst.setPixel32(x, y, src);
						}
					}
				}
			}

			return dst;
		}
	}
}