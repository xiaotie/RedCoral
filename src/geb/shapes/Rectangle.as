/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;

	public class Rectangle extends BaseShape
	{
		private var _corner:Number = NaN;

		public function get corner():Number
		{
			return _corner;
		}

		public function set corner(value:Number):void
		{
			_corner = value;
			this.invalidate();
		}

		private var _corners:Array = null;
		
		public function get corners():Array
		{
			return _corners;
		}

		public function set corners(value:Array):void
		{
			_corners = value;
			this.invalidate();
		}

		public override function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			if(width > 0 && height > 0)
			{
				var c0:Number = corner;
				var c1:Number = corner;
				var c2:Number = corner;
				var c3:Number = corner;
				
				var c:Array = this.corners;
				if(c != null && c.length == 4)
				{
					c0 = Number(c[0]);
					c1 = Number(c[1]);
					c2 = Number(c[2]);
					c3 = Number(c[3]);
				}
				
				if(isNaN(c0)) c0 = 0;
				if(isNaN(c1)) c1 = 0;
				if(isNaN(c2)) c2 = 0;
				if(isNaN(c3)) c3 = 0;
				
				if(isNaN(borderThickness) == false && borderThickness > 0)
				{
					g.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha,true, "normal","none","miter");
				}
				
				if(this.texture)
				{
					g.beginBitmapFill(this.texture);					
				}
				else
				{
					g.beginFill(color, this.fillAlpha);
				}
				if(c0 == 0 && c1 == 0 && c2 == 0 && c3 == 0)
				{
					g.drawRect(0,0,width,height);
				}
				else
				{
					g.drawRoundRectComplex(0,0,width,height,c0,c1,c2,c3);
				}
				g.endFill();
			}
		}
	}
}