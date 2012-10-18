/**
 * @author xiaotie@geblab.com 
 */

package geb.common
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.PNGEncoder;

	public class PaintContext extends Sprite
	{
		private var inner:Shape;
		private var outter:Shape;
		
		public var texture:BitmapData;
		public var strokeBorderColor:uint = 0xFF0000;
		public var strokeBorderThickness:Number = 3;
		public var strokeBorderAlpha:Number=1;
		public var strokeWidth:Number = 10;
		public var strokeColor:uint=0x00FF00;
		public var strokeAlpha:Number=1;
		
		public function getPoints():Array
		{
			return points;
		}
		
		public function PaintContext()
		{
			super();
			inner = new Shape();
			outter = new Shape();
			this.addChild(outter);
			this.addChild(inner);
		}
		
		public override function set alpha(val:Number):void
		{
			super.alpha = val;
			inner.alpha = val;
			outter.alpha = val;
		}
		
		private var points:Array = [];
		
		private function beginInnerDrawing(point:Point):void
		{
			inner.graphics.lineStyle(strokeWidth,strokeColor,strokeAlpha);
			
			if(texture != null)
			{
				inner.graphics.lineBitmapStyle(texture,null,true);
			}
			
			inner.graphics.moveTo(point.x,point.y);
		}
		
		private function beginOutterDrawing(point:Point):void
		{
			if(strokeBorderThickness <= 0) return;
			
			outter.graphics.lineStyle(strokeWidth+strokeBorderThickness*2,strokeBorderColor,strokeBorderAlpha);
			outter.graphics.moveTo(point.x,point.y);
		}
		
		public function drawLine(from:Point, to:Point):void
		{
			points.push(from.clone(),to.clone());
			beginOutterDrawing(from);
			outter.graphics.lineTo(to.x,to.y);
			beginInnerDrawing(from);
			inner.graphics.lineTo(to.x,to.y);
		}
		
		public function drawBitmapData(rect:Rectangle, bmpData:BitmapData, 
									   matrix:Matrix = null, repeat:Boolean = false, 
									   smooth:Boolean = false):void
		{
			if(bmpData == null) return;
			inner.graphics.beginBitmapFill(bmpData,matrix,repeat,smooth);
			inner.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			inner.graphics.endFill();
		}
		
		public function clear():void
		{
			outter.graphics.clear();
			inner.graphics.clear();
		}
	}
}