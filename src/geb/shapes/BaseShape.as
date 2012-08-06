/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	
	import geb.common.BaseComponent;
	
	public class BaseShape extends Shape
	{
		protected var _width:Number = NaN;
		protected var _height:Number = NaN;

		protected var inited:Boolean = false;
		public var updateNextFrame:Boolean = true;
		
		public function BaseShape()
		{
			super();
			invalidate();
		}
		
		public function invalidate():void
		{
			if(updateNextFrame == true)
			{
				removeEventListener(Event.ENTER_FRAME, onInvalidate);
				addEventListener(Event.ENTER_FRAME, onInvalidate);
			}
			else
			{
				onInvalidate(null);
			}
		}
		
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
			
			if(inited == false)
			{
				inited = true;
			}
		}
		
		public function draw():void
		{
		}
		
		private var _color:uint = 0xFFFFFF;
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			if(_color == value) return;
			
			_color = value;
			this.invalidate();
		}
		
		private var _fillAlpha:Number = 1;
		
		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}
		
		public function set fillAlpha(value:Number):void
		{
			_fillAlpha = value;
			this.invalidate();
		}
		
		private var _texture:BitmapData;
		
		public function get texture():BitmapData
		{
			return _texture;
		}
		
		public function set texture(value:BitmapData):void
		{
			_texture = value;
			this.invalidate();
		}
		
		private var _borderAlpha:Number = 1;
		
		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
			this.invalidate();
		}
		
		private var _borderColor:uint;
		
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		public function set borderColor(value:uint):void
		{
			_borderColor = value;
			this.invalidate();
		}
		
		private var _borderThickness:Number = NaN;
		
		public function get borderThickness():Number
		{
			return _borderThickness;
		}
		
		public function set borderThickness(value:Number):void
		{
			_borderThickness = value;
			this.invalidate();
		}
		
		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		private var _descriptor:Descriptor;
		
		public function get descriptor():Descriptor
		{
			return _descriptor;
		}
		
		public function set descriptor(value:Descriptor):void
		{
			_descriptor = value;
			if(_descriptor != null)
			{
				_descriptor.resize(this);
			}
		}
	}
}