package geb.shapes
{
	import flash.display.BitmapData;
	
	import geb.common.BaseComponent;

	public class BaseShapeUI extends BaseComponent
	{
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