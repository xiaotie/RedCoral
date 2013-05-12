/**
 * @author xiaotie@geblab.com 
 */

package geb.shapes
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import geb.common.BaseComponent;

	[Event(name="dragStart", type="flash.events.Event")]
	public class BaseShapeUI extends BaseComponent
	{
		private var _color:uint = 0xFFFFFF;
		private var _draging:Boolean;
		private var _dragable:Boolean = false;
		
		public function get draging():Boolean
		{
			return _draging;
		}
		
		public function get dragable():Boolean
		{
			return _dragable;
		}
		
		public function set dragable(value:Boolean):void
		{
			_dragable = value;
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			if(value == false)
			{
				if(stage != null)
				{
					onDrop(null);
				}
			}
			else
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			}
		}
		
		public var dragBounds:flash.geom.Rectangle;
		
		public var dragingFilters:Array = null;
		private var _oldFilters:Array = null;
		
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
		
		protected function canDrag(e:MouseEvent):Boolean
		{
			return true;
		}
		
		private function onDrag(e:MouseEvent):void
		{
			if(dragable == false) return;
			if(canDrag(e) == false) return;
			_oldFilters = this.filters;
			this.filters = dragingFilters;
			_draging = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			startDrag(false,dragBounds);
			this.dispatchEvent(new Event("dragStart"));
		}
		
		private function onDrop(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stopDrag();
			_draging = false;
			this.filters = _oldFilters;
		}
	}
}