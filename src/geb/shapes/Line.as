/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class Line extends BaseShape
	{
		private var _start:Point;

		public function get start():Point
		{
			return _start;
		}

		public function set start(value:Point):void
		{
			_start = value;
			this.invalidate();
		}

		private var _end:Point;

		public function get end():Point
		{
			return _end;
		}

		public function set end(value:Point):void
		{
			_end = value;
			this.invalidate();
		}
		
		private var _thickness:Number = 1;

		public function get thickness():Number
		{
			return _thickness;
		}

		public function set thickness(value:Number):void
		{
			_thickness = value;
			this.invalidate();
		}
		
		public override function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			if(start == null || end == null) return;
			g.moveTo(start.x, start.y);
			g.lineStyle(this.thickness, this.color);
			g.lineTo(end.x, end.y);
			g.endFill();
			super.draw();
		}

	}
}