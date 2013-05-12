package geb.image
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	public class ArgbImage2
	{
		public static function CreateFromBitmapData(data:BitmapData):ArgbImage2
		{
			var width:int=data.width;
			var height:int=data.height;
			var img:ArgbImage2=new ArgbImage2(data.width, data.height);
			var a:ByteArray=img.A.Data;
			var r:ByteArray=img.R.Data;
			var g:ByteArray=img.G.Data;
			var b:ByteArray=img.B.Data;
			var i:int=0;
			var c:uint=0;

				for (var w : int =0; w < width; w++)
				{
					for (var h : int =0; h < height; h++)
					{
						i=h * width + w;
						c=data.getPixel32(w, h);
						a[i]=(c >> 24) & 0xFF;
						r[i]=(c >> 16) & 0xFF;
						g[i]=(c >> 8) & 0xFF;
						b[i]=c & 0xFF;
					}
				}
			return img;
		}
		
		/**
		 * 创建一个 width * height 大小的 Argb图像。如果 a, r, g, b 四个 channel中的某channel为空，则创建一个默认的 width * height 大小的  ImageChannel 作为该 channel。 如果chennel不为空，则直接用作 ArgbImage 中的 channel.
		 */
		public function ArgbImage2(width:int, height:int, a : ImageChannel = null, r : ImageChannel = null, g : ImageChannel = null, b : ImageChannel = null)
		{
			this.Width=width;
			this.Height=height;
			this.A = UseImageChannelOrCreateWhenNull(a,"a");
			this.R = UseImageChannelOrCreateWhenNull(r,"r");
			this.G = UseImageChannelOrCreateWhenNull(g,"g");
			this.B = UseImageChannelOrCreateWhenNull(b,"b");
		}
		
		private function UseImageChannelOrCreateWhenNull(imgChannel:ImageChannel, channelName: String):ImageChannel
		{
			if(imgChannel == null) return new ImageChannel(this.Width, this.Height);
			else if(this.CheckSize(imgChannel) == false)
			{
				this.ThrowSizeException(channelName);
				return null;
			}
			else
				return imgChannel; 
		}
		
		private function CheckSize(imgChannel:ImageChannel):Boolean
		{
			if(this.Width == imgChannel.Width && this.Height == imgChannel.Height) return true;
			else return false;
		}
		
		private function ThrowSizeException(msg : String = ""):void
		{
			throw "尺寸不一致:" + msg;
		}
		
		public var A:ImageChannel;
		public var B:ImageChannel;
		public var G:ImageChannel;
		public var Height:int;
		public var R:ImageChannel;
		public var Width:int;
		
		public function Clone():ArgbImage2
		{
			return new ArgbImage2(this.Width,this.Height, this.A.Clone(), this.R.Clone(),this.G.Clone(),this.B.Clone());
		}

		public function ToBitmapData():BitmapData
		{
			var data:BitmapData=new BitmapData(this.Width, this.Height);
			var a:ByteArray=A.Data;
			var r:ByteArray=R.Data;
			var g:ByteArray=G.Data;
			var b:ByteArray=B.Data;
			var i:int=0;
			
			for (var w:int=0; w < this.Width; w++)
			{
				for (var h:int=0; h < this.Height; h++)
				{
					i=h * this.Width + w;
					
					if(a[i]!=0)
					{
						data.setPixel32(w,h,Util.createColorFromArgb(a[i],r[i],g[i],b[i]));
					}
					else
					{
						data.setPixel32(w, h, 0);
					}
				}
			}
			return data;
		}
		
		public function SetTransparentColor(color:uint):void
		{
			var a:ByteArray=A.Data;
			var r:ByteArray=R.Data;
			var g:ByteArray=G.Data;
			var b:ByteArray=B.Data;
			
			for (var w:int=0; w < this.Width; w++)
			{
				for (var h:int=0; h < this.Height; h++)
				{
					var i : int =h * this.Width + w;
					var value: uint = Util.createColorFromArgb(a[i],r[i],g[i],b[i]);
					if(color == value)
					{
						a[i]=0;
						r[i]=0;
						g[i]=0;
						b[i]=0;
					}	
				}
			}
		}
		
		/**
		 * 对图像进行变形，如：用鼠标在图像上选择一个圆形区域（区域半径为 radius ），
		 * 然后按住左键(rootX,rootY)，拖动，再松开左键(toX,toY)。对所选择的部分图像进行
		 * 变形。strength是变形强度，取值范围：1-100
		 */
		public function LocalMorph(rootX:int, rootY:int, toX:int, toY:int, radius:int, strength:int, radialBasisExponent:int,useBilinearInterpolation:Boolean = true):void
		{
			this.A.LocalMorph(rootX,rootY,toX,toY,radius,strength,radialBasisExponent,useBilinearInterpolation);
			this.R.LocalMorph(rootX,rootY,toX,toY,radius,strength,radialBasisExponent,useBilinearInterpolation);
			this.G.LocalMorph(rootX,rootY,toX,toY,radius,strength,radialBasisExponent,useBilinearInterpolation);
			this.B.LocalMorph(rootX,rootY,toX,toY,radius,strength,radialBasisExponent,useBilinearInterpolation);
		}
	}
}