/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class LineDescriptor extends Descriptor
	{
		public var start:Point;
		public var end:Point;
		
		public function LineDescriptor(p0:Point, p1:Point):void
		{
			start = p0;
			end = p1;
		}
		
		public override function resize(shape:DisplayObject):void
		{
			if(shape is Line)
			{
				Line(shape).start = start;
				Line(shape).end = end;
			}
			else if(shape is LineUI)
			{
				LineUI(shape).start = start;
				LineUI(shape).end = end;
			}
		}
	}
}