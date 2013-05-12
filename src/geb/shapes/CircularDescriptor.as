/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.DisplayObject;

	public class CircularDescriptor extends Descriptor
	{
		public var centerX:Number;
		public var centerY:Number;
		public var radius:Number;
		
		public function CircularDescriptor(centerX:Number,centerY:Number,radius:Number):void
		{
			this.centerX = centerX;
			this.centerY = centerY;
			this.radius = radius;
		}
		
		public override function resize(shape:DisplayObject):void
		{
			shape.x = centerX - radius;
			shape.y = centerY - radius;
			shape.width = radius * 2;
			shape.height = radius * 2;
		}
	}
}