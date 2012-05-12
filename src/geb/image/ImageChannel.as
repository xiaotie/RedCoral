package geb.image
{
	import flash.utils.ByteArray;
	
	/**
	 * 图像 Channel
	 */
	public class ImageChannel
	{
		public var Width:int;
		public var Height:int;
		public var Data:ByteArray;

		public function ImageChannel(width:int, height:int)
		{
			this.Width=width;
			this.Height=height;
			Data= Util.createByteArray(width*height);
		}
		
		public function Clone():ImageChannel
		{
			var img: ImageChannel = new ImageChannel(this.Width, this.Height);
			for(var i : int = 0; i < this.Data.length; i++)
			{
				img.Data[i] = this.Data[i];
			}
			return img;
		}
		
		/**
		 * 对图像进行变形，如：用鼠标在图像上选择一个圆形区域（区域半径为 radius ），
		 * 然后按住左键(rootX,rootY)，拖动，再松开左键(toX,toY)。对所选择的部分图像进行
		 * 变形。strength是变形强度，取值范围：1-1000
		 * radialBasisExponent 是使用的径向基函数（(1-x^2)^r）的幂，默认为2
		 */
		public function LocalMorph(rootX:int, rootY:int, toX:int, toY:int, radius:int = 20, strength:int = 100,radialBasisExponent:int = 2,useBilinearInterpolation:Boolean = true):void
		{
			// 参见 潘建江 等，图像的局部约束变形技术，计算机辅助设计与图形学学报, 2002(14),5
            // u=x - [((r^2-|x-c|^2)/r^2)^3]*(m-c)
            // 引入强度s，公式变为 u=x - [((r^2-|x-c|^2)/r^2)^3]*(m-c)*(s/1000)

			var rSquare : int = radius * radius;

            var transX : int = toX - rootX;
            var transY : int = toY - rootY;
            var transDistanceSquare : int = transX*transX+transY*transY; // dest 和 root 两点间距离的平方，也就是 |m-c|^2

            // 计算需要变形的框
            var fromX : int = Math.max(0, rootX - radius);
            var toX : int = Math.min(Width-1, rootX + radius);
            var fromY : int = Math.max(0, rootY - radius);
            var toY : int = Math.min(Height-1, rootY + radius);
            
            var windowWidth : int = radius * 2 + 1;
            var cache : ByteArray = Util.createByteArray(windowWidth*windowWidth);	// 用于存放中间计算结果

            for (var x : int = fromX; x <= toX; x++)
            {
                for (var y : int = fromY; y <= toY; y++)
                {
                    var distanceSquare : int = (x - rootX) * (x - rootX) + (y - rootY) * (y - rootY);   // |x-c|^2
                    var indexCache:int = (x - fromX) + (y - fromY) * windowWidth;
                    if (distanceSquare < rSquare)
                    {
                        var factor : Number = 1 - ((Number)(distanceSquare)) / rSquare;
                        if(radialBasisExponent == 2)
                        {
                        	factor = factor * factor;
                        }
                        else if(radialBasisExponent == 3)
                        {
                        	factor = factor * factor * factor;
                        }
                        else if(radialBasisExponent > 3)
                        {
                        	factor = Math.pow(factor,radialBasisExponent);
                        }
                        
                        factor = (factor*strength)/1000;
                        
                        var sourceX : Number = x - (factor * transX); // 反向变换点的x坐标
                        var sourceY : Number = y - (factor * transY); // 反向变换点的y坐标
                        var value : uint = useBilinearInterpolation == true? BilinearInterpolate(sourceX,sourceY) :  NearestNeighborInterpolate(sourceX,sourceY); 
                        cache[indexCache]=value;
                    }
                }
            }
            
            // 将 cache 中的结果写回 map 之中
            for (x = fromX; x <= toX; x++)
            {
                for (y = fromY; y <= toY; y++)
                {
                	distanceSquare  = (x - rootX) * (x - rootX) + (y - rootY) * (y - rootY);   // |x-c|^2
                	if (distanceSquare < rSquare)
                	{
                		indexCache = (x - fromX) + (y - fromY) * windowWidth;
                		var indexData : int = x + y * Width;
	                   	Data[indexData] = cache[indexCache];
                	}
                }
            }
		}
		
		private function BilinearInterpolate(x:Number, y:Number):uint
		{
			// 双线性内插值：
			// 对于一个目的像素，设置坐标通过反向变换得到的浮点坐标为(i+u,j+v)，其中i、j均为非负整数，u、v为[0,1)区间的浮点数，则这个像素得值 f(i+u,j+v) 可由原图像中坐标为 (i,j)、(i+1,j)、(i,j+1)、(i+1,j+1)所对应的周围四个像素的值决定，即：
			//
			// f(i+u,j+v) = (1-u)(1-v)f(i,j) + (1-u)vf(i,j+1) + u(1-v)f(i+1,j) + uvf(i+1,j+1)
			//
			// 其中f(i,j)表示源图像(i,j)处的的像素值，以此类推
			var intX:int=x;
			var intY:int=y;
			var intXpp:int=x + 1;
			var intYpp:int=y + 1;
			
			// 处理边界条件
			if(intXpp >= this.Width) intXpp = this.Width-1;
			if(intYpp >= this.Height) intYpp = this.Height -1;

            var u : Number = x - intX;
            var v : Number = y - intY;
            var f0 : Number = (1 - u) * (1 - v);
            var f1 : Number = (1 - u) * v;
            var f2 : Number = u * (1 - v);
            var f3 : Number = u * v;
            var i0 : int = intX + intY * Width;
            var i1 : int = intX + intYpp * Width;
            var i2 : int = intXpp + intY * Width;
            var i3 : int = intXpp + intYpp * Width;
            var r: int = f0*Data[i0]+f1*Data[i1]+f2*Data[i2]+f3*Data[i3];
            if(r<0) r = 0; else if(r>255) r = 255;

			return r;
		}
		
		private function NearestNeighborInterpolate(x:Number, y:Number):uint
		{
			// 最近邻插值：
			var intX:int=x;
			var intY:int=y;
			var intXpp:int=x + 1;
			var intYpp:int=y + 1;
			
			// 处理边界条件
			if(intXpp >= this.Width) intXpp = this.Width-1;
			if(intYpp >= this.Height) intYpp = this.Height -1;
			
            var v0 : int = Data[intX + intY * Width];
            var v1 : int = Data[intX + intYpp * Width];
            var v2 : int = Data[intXpp + intY * Width];
            var v3 : int = Data[intXpp + intYpp * Width];
            
            if(x-intX < 0.5)
            {
            	if(y-intY < 0.5)
            	{
            		return v0;
            	}
            	else
            	{
            		return v1;
            	}
            }
            else
            {
            	if(y-intY < 0.5)
            	{
            		return v2;
            	}
            	else
            	{
            		return v3;
            	}
            }
		}
	}
}