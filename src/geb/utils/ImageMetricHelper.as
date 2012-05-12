package geb.utils
{
	import flash.display.Bitmap;
	
	public class ImageMetricHelper
	{
		/**
		 * 对角线的弧度值 
		 */		
		public var diagonalLineTheta:Number;
		
		/**
		 * 对角线的长度值 
		 */		
		public var diagonalLineLength:Number;
		
		public var width:Number;
		
		public var height:Number;
		
		public function ImageMetricHelper(source:Object = null)
		{
			if(source == null)
			{
				return;
			}
			else if(source is Bitmap)
			{
				loadBitmap(Bitmap(source));
			}
		}
		
		private function loadBitmap(bmp:Bitmap):void
		{
			width = bmp.width;
			height = bmp.height;
			diagonalLineTheta = Math.atan2(bmp.width, bmp.height);
			diagonalLineLength = Math.sqrt(bmp.width * bmp.width + bmp.height * bmp.height);
		}
		
		/**
		 * 获得针对指定长宽的最大缩放尺度 
		 * @param width 宽
		 * @param height 长
		 * @param rotation 图像的旋转角度
		 * @return 最大缩放尺度
		 * 
		 */		
		public function getMaxFitScale(width:Number, height:Number, rotation:Number = 0):Number
		{
			var scaleX:Number;
			var scaleY:Number;
			
			if(rotation == 0 || rotation == 180)
			{
				scaleX = width / this.width;
				scaleY = height / this.height;
			}
			else
			{
				var r:Number = Math.PI * rotation / 180;
				var t0:Number = diagonalLineTheta + r;
				var w0:Number = Math.abs(diagonalLineLength * Math.sin(t0));
				var h0:Number = Math.abs(diagonalLineLength * Math.cos(t0));
				var t1:Number = -diagonalLineTheta + r;
				var w1:Number = Math.abs(diagonalLineLength * Math.sin(t1));
				var h1:Number = Math.abs(diagonalLineLength * Math.cos(t1));
				var w:Number = Math.max(w0,w1);
				var h:Number = Math.max(h0,h1);
				scaleX = width / w;
				scaleY = height / h;
			}
			return Math.min(scaleX,scaleY);
		}
	}
}