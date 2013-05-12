/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.DisplayObject;

	public class RectangleDescriptor  extends Descriptor
	{
		public var centerX:Number;
		public var centerY:Number;
		public var width:Number;
		public var height:Number;
		
		public function RectangleDescriptor(centerX:Number,centerY:Number,width:Number, height:Number = NaN):void
		{
			this.centerX = centerX;
			this.centerY = centerY;
			this.width = width;
			this.height = isNaN(height)?width:height;
		}
		
		public override function resize(shape:DisplayObject):void
		{
			shape.x = centerX - width * 0.5;
			shape.y = centerY - height * 0.5;
			shape.width = width;
			shape.height = height;
		}
	}
}