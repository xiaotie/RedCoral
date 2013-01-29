/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;
	import flash.geom.Point;

	public class CircleUI extends BaseShapeUI
	{
		private var _center:Point = new Point(2,2);
		
		private var _radius:Number = 2;
		
		[Bindable]
		public function get center():Point
		{
			return new Point(x + 0.5*width, y + 0.5*height);
		}

		public function set center(value:Point):void
		{
			if(value == null) return;
			
			_center = value.clone();
			layout();
		}

		[Bindable]
		public function get radius():Number
		{
			return 0.5*width;
		}

		public function set radius(value:Number):void
		{
			if(value < 0 ) return;
			
			_radius = value;
			layout();
		}
		
		private function layout():void
		{
			x = _center.x - _radius;
			y = _center.y - _radius;
			width = 2*_radius;
			height = 2*_radius;
		}

		public override function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			if(width > 0 && height > 0)
			{
				if(isNaN(borderThickness) == false && borderThickness > 0)
				{
					g.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
				}
				
				if(this.texture)
				{
					g.beginBitmapFill(this.texture);					
				}
				else
				{
					g.beginFill(color, this.fillAlpha);
				}
				g.drawEllipse(0,0,width,height);
				g.endFill();
			}
			
			super.draw();
		}
	}
}