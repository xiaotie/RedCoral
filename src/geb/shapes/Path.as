/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.Graphics;
	
	public class Path extends BaseShape
	{
		private var _points:Array;
		
		public function get points():Array
		{
			return _points;
		}
		
		public function set points(value:Array):void
		{
			if(_points == value) return;
			
			_points = value;
			this.draw();
		}
		
		public override function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			
			if(points == null || points.length == 0) return;
			
			if(isNaN(borderThickness) == false && borderThickness > 0)
			{
				g.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha,true);
			}
			
			g.moveTo(points[0].x,points[0].y);
			
			for(var i:int = 1; i < points.length; i++)
			{
				g.lineTo(points[i].x,points[i].y);
			}
		}
	}
}